<?php

namespace app\common\model;

use think\Exception;
use think\Model;

// 公共模型方法
class Base extends Model
{
    /**
     * @param $where           //查询条件
     * @param string $field    //查询字段
     * @return array
     */
    public function getInfo($where, $field = '*', $order='')
    {
        try{
            $res = $this->where($where)->field($field)->order($order)->find();
            if (null === $res) {
                return ['code' => 400,'msg' => $this->getError()];
            } else {
                return ['code' => 200,'data' => $res];
            }
        }catch (Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
    }

    /**
     * 列表查询
     * @param $page            //页数
     * @param $limit           //数量
     * @param $where           //查询条件
     * @param string $field    //查询字段
     * @param string $order    //查询顺序
     * @return array
     */
    public function getList($page = 0, $limit = 0, $where = [], $field='*', $order = '')
    {
        try{
            $page = ($page - 1) * $limit;
            $res = $this->where($where)->field($field)->order($order)->limit($page,$limit)->select();
            // $res = $this->where($where)->field($field)->order($order)->limit($page,$limit)->select()->toArray();
            if (false === $res) {
                return ['code' => 400,'msg' => $this->getError()];
            } else {
                return ['code' => 200,'data' => $res];
            }
        }catch (Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
    }

    /**
     * 添加数据
     * @param $data
     * @return array
     */
    public function add($data)
    {
        try{
            $res = $this->allowField(true)->isUpdate(false)->save($data);
            if (false === $res) {
                return ['code' => 400,'msg' => $this->getError()];
            } else {
                return ['code' => 200,'data'=> $this->id];
            }
        }catch (Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
    }

    /**
     * 批量添加数据
     * @param array $data 添加数据
     * @param string $field 过滤字段
     * @return array
     */
    public function addAll($data, $field = [])
    {
        try{
            $res = $this->allowField($field)->saveAll($data);
            if (false === $res) {
                return ['code' => 400,'msg' => $this->getError()];

            } else {
                return ['code' => 200];
            }
        }catch (Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
    }

    /**
     * 更新数据(带主键)
     * @param $data
     * @return array
     */
    public function edit($data)
    {
        try{
            $res = $this->allowField(true)->isUpdate(true)->save($data);
            if (false === $res) {
                return ['code' => 400,'msg' => $this->getError()];
            } else {
                return ['code' => 200];
            }
        }catch (Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
    }

    /**
     * 更新数据(不带主键)
     * @param array $data   更新数据
     * @param array $where  更新条件
     * @param array $field  指定字段
     * @return array
     */
    public function editWhere($data, $where= [])
    {
        try{
            $res = $this->allowField(true)->where($where)->update($data);
            if (false === $res) {
                return ['code' => 400,'msg' => $this->getError()];
            } else {
                return ['code' => 200];
            }
        }catch (Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
    }

    /**
     * 删除数据
     * @param $ids
     * @return array
     */
    public function del($ids,$type = false)
    {
        try{
            $res = $this->destroy($ids,$type);
            if (false === $res) {
                return ['code' => 400,'msg' => $this->getError()];
            } else {
                return ['code' => 200];
            }
        }catch (Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
    }

    /**
     * 删除数据
     * @param  string $where 删除的条件
     * @return array
     */
    public function delWhere($where)
    {
        try{
            $res = $this->where($where)->delete();

            if ($res == 0) {
                return ['code' => 400,'msg' => '数据错误'];
            } else {
                return ['code' => 200];
            }
        }catch (Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
    }

    /**
     * 查询数量
     * @param $where
     * @return array
     */
    public function getCount($where = []){
        try {
            $res = $this->where($where)->count();
            if (false === $res) {
                return ['code' => 400,'msg' => $this->getError()];
            } else {
                return ['code' => 200,'data' => $res];
            }
        }catch (Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
    }

    /**
     * 统计和
     * @param array $where 查询条件
     * @return array
     */
    public function getSum($where = [], $field){
        try {
            $res = $this->where($where)->sum($field);
            if (false === $res) {
                return ['code' => 400,'msg' => $this->getError()];
            } else {
                return ['code' => 200,'data' => $res];
            }
        }catch (Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
    }

    /**
     * 获取某个字段值
     * @param $where       //查询条件
     * @param $value       //查询字段
     * @return array
     */
    public function getVal($where,$value){
        try {
            $res = $this->where($where)->value($value);
            if (false === $res) {
                return ['code' => 400,'msg' => $this->getError()];
            } else {
                return ['code' => 200,'data' => $res];
            }
        }catch (Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
    }

    /**
     * 获取某个列
     * @param array  $where  查询条件
     * @param string $value  查询字段
     * @return array
     */
    public function getCol($where = [], $value, $order=''){
        try {
            $res = $this->where($where)->order($order)->column($value);
            if (false === $res) {
                return ['code' => 400,'msg' => $this->getError()];
            } else {
                return ['code' => 200,'data' => $res];
            }
        }catch (Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
    }

    /**
     * 字段自减
     * @param $where   //查询条件
     * @param $field   //修改字段
     * @param $num     //自减数量
     * @return array
     */
    public function setDecField($where, $field, $num = 1){
        try {
            $res = $this->where($where)->setDec($field, $num);
            if (false === $res) {
                return ['code' => 400,'msg' => $this->getError()];
            } else {
                return ['code' => 200,'data' => $res];
            }
        }catch (Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
    }

    /**
     * 字段自增
     * @param $where   //查询条件
     * @param $field   //修改字段
     * @param $num     //自增数量
     * @return array
     */
    public function setIncField($where, $field, $num = 1){
        try {
            $res = $this->where($where)->setInc($field, $num);
            if (false === $res) {
                return ['code' => 400,'msg' => $this->getError()];
            } else {
                return ['code' => 200,'data' => $res];
            }
        }catch (Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
    }
}
