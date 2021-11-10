<?php

namespace app\common\model;

use think\Model;

// 广告表
class Advertisement extends Base
{
    // 广告位置
    public function getPositionAttr($v)
    {
        $arr = [1=>'第一广告位', 2=>'第二广告位', 3=>'第三广告位'];
        return $arr[$v];
    }

    // 第几期广告
    public function getStageAttr($v)
    {
        $arr = [1=>'第一期广告', 2=>'第二期广告', 3=>'第三期广告', 4=>'第四期广告'];
        return $arr[$v];
    }

    
}
