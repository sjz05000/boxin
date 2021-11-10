<?php

namespace app\capi\controller;

use think\Controller;

use app\common\controller\Base;
use app\common\model\User;
use app\common\model\Sms;

// use app\common\model\
// use app\common\model\

class Login extends Base
{

    /**
     * 测试
     */
    public function ceshi()
    {
        // $a = strpos('Longway','way');
        // if($a !== false){ 
        //     echo '包含way';
        //    }else{
        //     echo '不包含way';
        //    }
        // halt($a);
        // 二维码
        // dump(scerweima(13,1));
        // 唯一ID
        // halt(only());
        // josn 数据
        // $arr = [1,2,32];
        // db('ceshi')->insert(['title'=>json_encode($arr)]);
        // 生产1个数组,要n个元素
        // halt(getDoctorNo(5));
        $a = [
            // ['link'=>'https://fanyi.baidu.com/', 'ID'=>234324],
            // ['link'=>'https://fanyi.baidu.com/', 'ID'=>234324],
            '水电费冷水的理念律师代理费第三方,说法第三方第三方离开胜多负少的',
            '是的粉色完全是的福利是的奶粉了是的范德萨发生的发',
        ];
        // halt(json_encode($a));
        // db('ceshi')->insert(['title'=>json_encode($a)]);
    }


    /**
     * 手机号注册
     */
    public function register()
    {
        $result = $this->validate($this->param,'app\common\validate\Login.login_sms');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $userModel = new User();
        $is_user = $userModel->getInfo(['phone'=>$this->param['phone']]);
        if($is_user['code'] == 200){
            $this->result([], 400, '该手机号已注册');
        }

        $this->param['only'] = $this->only();
        $this->param['nickname'] = nickname();
        $res = $userModel->add($this->param);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        $this->result(['token'=>$this->jwt($res['data'])], 200, '注册成功');
    }

    /**
     * 手机号验证码/密码登录
     */
    public function login()
    {
        $userModel = new User();

        if($this->param['type'] == 1){

            // 手机验证码登录
            $result = $this->validate($this->param,'app\common\validate\Login.login_sms');
            if(true !== $result){
                // 验证失败 输出错误信息
                $this->result([], 400, $result);
            }

            $is_user = $userModel->getInfo(['phone'=>$this->param['phone']], 'id');
            if($is_user['code'] != 200){
                $this->result([], 400, '手机号错误');
            }
            $smsModel = new Sms();
            $code = $smsModel->checkCode($this->param['phone'], $this->param['code']);
            if($code['code'] != 200){
                $this->result([], 400, $code['msg']);
            }

            // 最后登录时间
            $userModel->edit(['id'=>$is_user['data']['id'], 'login_time'=>time()]);
            // 验证码已使用
            $smsModel->edit(['id'=>$code['data'], 'is_use'=>1]);

            $this->result(['token'=>$this->jwt($is_user['data']['id'])], 200, '登录成功');
        }else{

            // 手机号密码登录
            $result = $this->validate($this->param,'app\common\validate\Login.login_pwd');
            if(true !== $result){
                // 验证失败 输出错误信息
                $this->result([], 400, $result);
            }

            $user_info = $userModel->getInfo(['phone'=>$this->param['phone']], 'id, pwd');
            if($user_info['code'] != 200){
                $this->result([], 400, '手机号错误');
            }
            
            // 密码验证
            if(setPwd($this->param['pwd']) != $user_info['data']['pwd']){

                $this->result([], 400, '密码错误');
            }else{

                // 最后登录时间
                $userModel->edit(['id'=>$user_info['data']['id'], 'login_time'=>time()]);

                $this->result(['token'=>$this->jwt($user_info['data']['id'])], 200, '登录成功');
            }

        }

    }

    /**
     * 人脸识别
     */
    public function face_recognition()
    {
        
    }

    /**
     * 更改密码
     */
    public function change_pwd()
    {
        $result = $this->validate($this->param,'app\common\validate\Login.change_pwd');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $userModel = new User();
        $res = $userModel->editWhere(['pwd'=>setPwd($this->param['new_pwd_two'])], ['phone'=>$this->param['phone']]);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        $this->result([], 200, '修改成功');
    }

    /**
     * 发送验证码
     */
    public function sms()
    {
        $smsModel = new Sms();

        $result = $this->validate($this->param,'app\common\validate\Login.sms');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $code = rand(1111, 9999);
        $res = sendSms($this->param['phone'],$code);
        // $res = 1;
        if($res > 0){
            $data = [
                'phone' => $this->param['phone'], 
                'code'  => $code, 
                'expiration_time' => strtotime("+5 minute")
            ];
            $smsModel->add($data);
            $this->result([], 200, '发送成功');
        }else{
            $this->result([], 400, '发送失败');
        }
    }

    /**
     * 用户唯一ID
     */
    private function only()
    {
        $userModel = new User();
        $only = only();
        $res = $userModel->getInfo(['only'=>$only]);
        if($res['code'] == 200){
            $this->only();
        }
        return $only;
    }
}
