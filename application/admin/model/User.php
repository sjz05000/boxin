<?php

namespace app\admin\model;

use think\Model;

// 用户表
class User extends Model
{   

    protected $table = 's_admin';
    //自定义初始化
    protected function initialize()
    {
         
         parent::initialize();
       
    }

}
