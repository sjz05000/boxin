<?php

namespace app\common\model;

use think\Model;

// 用户交易记录
class MoneyLog extends Base
{

    public function getMoneyTypeAttr($v)
    {
        $arr = [1=>'余额', 2=>'冻结金', 3=>'预付金'];
        return $arr[$v];
    }

}
