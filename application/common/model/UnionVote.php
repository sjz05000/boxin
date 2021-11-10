<?php

namespace app\common\model;

use think\Model;

// 投票记录表
class UnionVote extends Base
{

    public function getUnIdAttr($v)
    {
        $res = (new UnionClass())->getInfo(['id'=>$v], 'title, logo');
        if($res['code'] == 200){
            return $res['data'];
        }
    }
}
