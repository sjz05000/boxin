<?php

namespace app\common\model;

use think\Model;
use think\Db;
use think\Exception;

// 商品表
class Commodity extends Base
{

    /**
     *  条件搜索  商品名称
     */
    public function position_goods($where,$limit)
    {
        try{
            $res = Db::table('s_commodity')
            ->alias('c')
            ->join('s_business b','c.b_id = b.id')
            ->where($where)
            ->field('c.id, c.title, c.title_img, c.favorable_price, c.original_price')
            ->page($limit)
            ->select();

        return $res;

        }catch (Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
        
    }

    // 测试,无用的
    public function position_goods_s($where,$limit)
    {
        try{
            $res = Db::table('s_commodity')
            ->alias('c')
            ->join('s_business b','c.b_id = b.id')
            ->join('s_business b','c.b_id = b.id')
            ->where($where)
            ->field('c.id, c.title, c.title_img, c.favorable_price, c.original_price')
            ->page($limit)
            ->select();

        return $res;

        }catch (Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
        
    }

    /**
     * 商品头图加域名
     */
    public function getTitleImgAttr($v)
    {
        $arr = json_decode($v);

        // 存储方式  第三方存储  本地服务器存储
        if(strpos($arr[0],'uploads') === false){
            // 文件录入(不加域名), 第三方存储录入(加域名)
            if(strpos($arr[0],'http') === false){ 
                foreach($arr as &$vv)
                {
                    $vv = config('app.qiniu.cdnUrl').$vv;
                }
            }
        }else{
            // 本地服务器录入
            foreach($arr as &$vv)
            {
                $vv = config('app.url').$vv;
            }

        }
        return $arr;
    }
    /**
     * 商品详情图片加域名
     */
    public function getDetailsAttr($v)
    {
        $arr = json_decode($v);

        // 存储方式  第三方存储  本地服务器存储
        if(strpos($arr[0],'uploads') === false){
            // 文件录入(不加域名), 第三方存储录入(加域名)
            if(strpos($arr[0],'http') === false){ 
                foreach($arr as &$vv)
                {
                    $vv = config('app.qiniu.cdnUrl').$vv;
                }
            }
        }else{
            // 本地服务器录入
            foreach($arr as &$vv)
            {
                $vv = config('app.url').$vv;
            }

        }
        return $arr;
    }
}
