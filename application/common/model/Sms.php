<?php

namespace app\common\model;

use think\Model;
use think\exception;

// 短信验证码表
class Sms extends Base
{
    //
    public function checkCode($phone, $code)
    {
        try{
            $res = $this->getInfo(['phone' => $phone, 'is_use' => 0], '*', 'id desc');

            if ($res['code'] != 200) {
                return ['code' => 400,'msg' => "验证码不存在"];
            }
            if ($code != $res['data']['code']) {
                return ['code' => 400,'msg' => '验证码错误'];
            }

            if (time() > $res['data']['expiration_time']) {
                return ['code' => 400,'msg' => '验证码已过期'];
            }

            return ['code' => 200, 'data' => $res['data']['id']];
        }catch(Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
    }
}