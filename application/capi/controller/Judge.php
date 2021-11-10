<?php

namespace app\capi\controller;

use think\Controller;
use app\common\model\User;
use think\Db;
// 判断用户 
class Judge extends Controller
{
    /**
     * 用户加入的后援会
     */
    /**
     * 用户加入联盟
     */

    /**
     * 先检测 是否明星 , 是否 联盟 待定
     */

    /**
     * 检查游客/正式用户
     * c 端 0=>游客 1=>正式用户
     */
    public function is_user($id)
    {
        return db('user')->where(['id'=>$id])->value('is_user');
    }

}
