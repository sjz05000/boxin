<?php

namespace app\common\model;

use think\Model;

// 用户 购买联盟卡 记录表
class UserUnionCard extends Base
{
    /**
     *  首页-联盟卡/码-类别搜索
     */
    public function class_search($page, $limit, $where)
    {
        $res = $this->alias('uu')
        ->join('union u','u.id = uu.u_id')
        ->where($where)
        ->field('u.id, u.union_card_logo, u.union_card_name, u.union_card_price, u.union_card_style, union_card_discount, uu.frequency')
        ->page($page, $limit)
        ->select();

        foreach($res as &$v)
        {
            // 存储方式  第三方存储  本地服务器存储
            if(strpos($v['union_card_logo'],'uploads') === false){
                $v['union_card_logo'] = config('app.qiniu.cdnUrl').$v['union_card_logo'];
            }else{
                $v['union_card_logo'] = config('app.url').$v['union_card_logo'];
            }
        }

        return $res;
    }
}
