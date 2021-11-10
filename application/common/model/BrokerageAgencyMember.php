<?php

namespace app\common\model;

use think\Model;

// c 端 经纪公司艺人成员表
class BrokerageAgencyMember extends Base
{
    
    public function getTypeAttr($v)
    {
        $arr = [1=>'内部', 2=>'外部'];
        return $arr[$v];
    }
}
