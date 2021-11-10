<?php

namespace app\common\validate;

use think\Validate;

class Login extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
	protected $rule = [
        'phone'  => 'require|mobile',
        'code'   => 'require',
        'pwd'    => 'require',
        'age'   => 'number|between:1,120',
        'email' => 'email',
        'new_pwd_one' => 'require',
        'new_pwd_two' => 'require|confirm:new_pwd_one',
    ];
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message = [
        'phone.require' => '手机号必填',
        'phone.mobile'  => '手机号格式错误',
        'code.require'  => '验证码必填',
        'pwd.require'   => '密码必填',
        'new_pwd_one.require'   => '新密码必填',
        'new_pwd_two.require'   => '新密码必填',
        'new_pwd_two.confirm'   => '两次密码不一致',
    ];

    /**
     * 验证场景
     */
    protected $scene = [
        'sms'  =>  ['phone'],
        'login_sms' => ['phone', 'code'],
        'login_pwd' => ['phone', 'pwd'],
        'change_pwd' => ['phone', 'new_pwd_one', 'new_pwd_two'],
    ];
}
