<?php

namespace app\common\model;

use think\Model;
use think\Db;
use think\Exception;

// 联盟内的商家
class UnionBusiness extends Base
{
    /**
     * c 端首页
     * 联盟专栏
     * 商家列表
     */
    public function business_list($where, $limit)
    {
        try{
            $res = $this->alias('ub')
            ->join('s_business b','ub.b_id = b.id')
            ->where($where)
            ->field('b.id, b.name, b.logo, b.b_id, b.address, ub.u_id')
            ->page($limit)
            ->select()
            ->toArray();
        
        $ccm = new CommodityClass();
        foreach($res as &$v)
        {
            // 存储方式  第三方存储  本地服务器存储
            if(strpos($v['logo'],'uploads') === false){
                $v['logo'] = config('app.qiniu.cdnUrl').$v['logo'];
            }else{
                $v['logo'] = config('app.url').$v['logo'];
            }
        
            $v['b_id'] = $ccm->getVal(['id'=>$v['b_id']], 'title')['data'];
        }

        return $res;

        }catch (Exception $e){
            return ['code' => 400,'msg' => $e->getMessage()];
        }
    }
}
