<?php

namespace app\capi\controller;

use think\Controller;
use app\common\model\RankingList; // 排行表12个数据
use app\common\model\User;
use app\common\model\Business;    // 商家表
use app\common\model\Union;       // 联盟表
use app\common\model\StarBackupMember; // 后援会成员表
use app\common\model\NoticeUserC;      // 用户与通知消息关系表
use app\common\model\NoticeNews;       // 重要通知
use app\common\model\NoticeBackup;     // 后援会通知
use app\common\model\NoticeBusiness;   // 店铺通知
use app\common\model\NoticeUnion;      // 联盟通知
use app\common\model\UserCollection;   // 用户收藏表
use app\common\model\RedEnvelopes;     // 红包表
use app\common\model\RedEnvelopesUser; // 用户与红包关系表
use app\common\model\PlatformData;     // 平台信息表
use app\common\model\Star;             // 明星信息表
use app\common\model\StarBackup;  // 后援会表
use app\common\model\Advertisement;  // 广告位
use app\common\model\AdvertisementExamine;
// use app\common\model\;
// use app\common\model\;

use think\Db;


class Timing extends Controller
{
    /**
     * 需要每日 00:00:00 执行的
     * 商品促销到期  0
     * 检测广告位过期
     */
    public function everyday()
    {
        // 红包到期
        $this->red_exp();

        // 每月的1号 , 8 号, 16号, 24号 00:00:00 检测广告过期
        if(in_array(date("j"), [1, 8, 16, 24])){
            $this->advertising_space();
        }
        // 每个月三号结上个月的广告费  时间写活，可设定的
        // 广告费用分成分配,  艺人详情,后援会广告位,给前3粉丝,再清零 
    }

    /**
     * 每1小时 
     * 统计排行榜
     */
    public function ranking_list()
    {
        // 清空数据表
        $rankinglistModel = new RankingList();
        $ranking_list = $rankinglistModel->delWhere('1=1');
        
        $this->star_partner(); // 明星合作商家贡献排行
        $this->alliance_card(); // 联盟卡销量排行
        $this->fan_ranking();      // 明星所有后援会的粉丝数量
        $this->alliance_commodity(); // 联盟商品销量
    }

    /**
     * 每月1号,00:00:00执行
     */
    public function month_go()
    {
        $this->clean_notice();   // 清理消息通知 ????????????????????
        $this->up_backup();      // 计算上月后援会分成
        $this->star_sort();      // 月结综合后援会


        // 10 个排行 月初保存一下, 首页->明星贡献 4个 实时的  明星详情->后援后排行 4个月排的  1个 明星详情->明星后援会综合 实时排行 ,   1个 后援会贡献前3粉丝, 实时排行
        $this->statistics();   // ????????????????????

        // c 端 艺人详情, 投票商品, 投票关系表清除
        $this->vote();
    }

    /**
     * 统计图
     */
    private function statistics()
    {
        // 等
        // db('StarStatistics')
    }

    /**
     * 明星合作商家贡献排行
     */
    private function star_partner($page = 1, $limit = 3)
    {
        $unionModel = new Union();
        $rankinglistModel = new RankingList();
        $union_list = $unionModel->getList($page, $limit, ['type'=>1, 'status'=>1, 'is_display'=>1], 'id', 'business_number desc');
        if($union_list['code'] != 200)
        {
            $this->result([], 400, $union_list['msg']);
        }

        $info =[];
        foreach($union_list['data'] as $k=>$v)
        {
            $info[] = [
                'obj_type' => 1,
                'obj_id' => $v['id'],
            ];
           
        }
        $rankinglistModel->addAll($info);

    }
    /**
     * 联盟卡销量排行
     */
    private function alliance_card($page = 1, $limit = 3)
    {
        $unionModel = new Union();
        $rankinglistModel = new RankingList();
        $union_list = $unionModel->getList($page, $limit, ['type'=>1, 'status'=>1, 'is_display'=>1], 'id', 'union_card_sell desc');
        if($union_list['code'] != 200){
            $this->result([], 400, $union_list['msg']);
        }
        $info =[];
        foreach($union_list['data'] as $k=>$v)
        {
            $info[] = [
                'obj_type' => 2,
                'obj_id' => $v['id'],
            ];
        }
        $rankinglistModel->addAll($info);
    }
    /**
     * 明星所有后援会的粉丝数量
     */
    private function fan_ranking($page = 1, $limit = 3)
    {
        $res = (new Star())->getList($page, $limit, ['is_display'=>1], 'id', 'fans_number desc');
        if($res['code'] != 200)
        {
            $this->result([], 400, $res['msg']);
        }

        $info =[];
        foreach($res['data'] as $k=>$v)
        {
            $info[] = [
                'obj_type' => 3,
                'obj_id' => $v['id'],
            ];
        }

        $rankinglistModel = new RankingList();
        $res = $rankinglistModel->addAll($info);

    }
    /**
     * 联盟商品销量排行 
     */
    private function alliance_commodity($page = 1, $limit = 3)
    {
        $unionModel = new Union();
        $rankinglistModel = new RankingList();
        $union_list = $unionModel->getList($page, $limit, ['type'=>1, 'status'=>1, 'is_display'=>1], 'id', 'union_sales desc');
        $info =[];
        foreach($union_list['data'] as $k=>$v)
        {
            $info[] = [
                'obj_type' => 4,
                'obj_id' => $v['id'],
            ];
        }
        $rankinglistModel->addAll($info);
    }

    /**
     * 清理上期广告位
     * 每月 1号 , 8 号, 16号, 24号 00:00:00检测过期
     */
    private function advertising_space()
    {

        // 获取当前的期数, $stage 为本期的, $a 为上一期的
        $t = date("j");
        if($t >= 1 && $t < 8){
            // $stage = 1;
            $a = 4;
        }else if($t >= 8 && $t < 16){
            // $stage = 2;
            $a = 1;
        }else if($t >= 16 && $t < 24){
            // $stage = 3;
            $a = 2;
        }else{
            // $stage = 4;
            $a = 3;
        }
        db('advertisement')->where(['stage'=>$a, 'status'=>['in','0,1']])->update(['status'=>2]);
    }

    /**
     * 后援会 月结一次
     * 排列规则：按成员数(1)+联盟卡推广数+介绍商家数的总数进行动态排名，联盟卡推广数加权数为2，介绍商家数加权数为3，商品购买加权数为4
     */
    private function star_sort()
    {

        // // 清空数据表
        // $arr=Db::name('star_sort')->where('1=1')->delete();

        $abm = new StarBackup();

        // 获取明星id
        $res_a = (new Star())->getList(0, 0, [], 'user_id');
        if($res_a['code'] != 200){
            $this->result([], 400, $res_a['msg']);
        }

        $list = [];  // 存放数据的数组
        $i=0;
        foreach($res_a['data'] as $v)
        {
            // 获取排完序后的后援会id
            $res_b = $abm->getList(0, 0, ['star_id'=>$v['user_id']], 'id', 'total_ranking desc');
            if($res_b['code'] != 200){
                continue;
            }
            foreach($res_b['data'] as $vv)
            {   
                $list[$i]['star_id'] = $v['user_id'];
                $list[$i]['sb_id'] = $vv['id'];
                $list[$i]['create_time'] = time();
                $i++;
            }
        }

        $num = 100;//每次导入条数
        $limit = ceil(count($list)/$num);
        for($i=1;$i<=$limit;$i++){
            $offset=($i-1)*$num;
            $data=array_slice($list,$offset,$num);
            $result=Db::name('star_sort')->insertAll($data);
        };


    }

    /**
     * 每日 00:00:00
     * b 端  商品促销到期
     */


    /**
     * 每月 1 号 04:00
     * 用户发布的通知信息，用户自行删除，用户和平台官方信息每个月一号清除上上个月的信息
     * 也就是一直保留一个月的信息
     */
    private function clean_notice()
    {
        // 查询条件
        $month_start = strtotime(date("Y-m-01"));
        $create_time = strtotime("-1 month", $month_start);

        // 用户已读字段 id
        $nucm = new NoticeUserC();
        $list = $nucm->getList(0, 0, [], 'id, nn_id, nbu_id, nbs_id, nuu_id');
        if($list['code'] != 200){
            $this->result([], 400, $list['msg']);
        }


        $this->dimportant_del($create_time, $list);
        $this->backup_del($create_time, $list);
        $this->shop_del($create_time, $list);
        $this->union_del($create_time, $list);
    }
    /**
     * 删除重要通知
     */
    private function dimportant_del($create_time, $list)
    {
        $nnm = new NoticeNews();

        // 要删除的过期id
        $arr = $nnm->getCol([ ['create_time', '<', $create_time] ], 'id');
        if($arr['code'] != 200){
            $this->result([], 400, $arr['msg']);
        }

        // 用户已读字段 id, 把上面要删除的id ,从用户已读字段去了
        $nucm = new NoticeUserC();

        foreach($list['data'] as $v)
        {
            $arr_id = $v['nn_id'] != null ? json_decode($v['nn_id']) : [];
            $data = array_diff($arr_id, $arr['data']);
            sort($data);
            $nucm->edit(['id'=>$v['id'], 'nn_id'=>json_encode($data)]);
        }
        // 删除消息 id
        $nnm->del($arr['data']);
    }
    /**
     * 删除后援会通知
     */
    private function backup_del($create_time, $list)
    {
        $nbm = new NoticeBackup();

        // 要删除的过期id
        $arr = $nbm->getCol([ ['create_time', '<', $create_time] ], 'id');
        if($arr['code'] != 200){
            $this->result([], 400, $arr['msg']);
        }

        // // 用户已读字段 id, 把上面要删除的id ,从用户已读字段去了
        $nucm = new NoticeUserC();

        foreach($list['data'] as $v)
        {
            $arr_id = $v['nbu_id'] != null ? json_decode($v['nbu_id']) : [];
            $data = array_diff($arr_id, $arr['data']);
            sort($data);
            $nucm->edit(['id'=>$v['id'], 'nbu_id'=>json_encode($data)]);
        }
        // 删除消息 id
        $nbm->del($arr['data']);
    }
    /**
     * 删除店铺通知
     */
    private function shop_del($create_time, $list)
    {
        $nbms = new NoticeBusiness();

        // 要删除的过期id
        $arr = $nbms->getCol([ ['create_time', '<', $create_time] ], 'id');
        if($arr['code'] != 200){
            $this->result([], 400, $arr['msg']);
        }

        // // 用户已读字段 id, 把上面要删除的id ,从用户已读字段去了
        $nucm = new NoticeUserC();

        foreach($list['data'] as $v)
        {
            $arr_id = $v['nbs_id'] != null ? json_decode($v['nbs_id']) : [];
            $data = array_diff($arr_id, $arr['data']);
            sort($data);
            $nucm->edit(['id'=>$v['id'], 'nbs_id'=>json_encode($data)]);
        }

        // 删除信息id
        $nbms->del($arr['data']);
    }
    /**
     * 删除联盟通知
     */
    private function union_del($create_time, $list)
    {
        $num = new NoticeUnion();

        // 要删除的过期id
        $arr = $num->getCol([ ['create_time', '<', $create_time] ], 'id');
        if($arr['code'] != 200){
            $this->result([], 400, $arr['msg']);
        }

        // // 用户已读字段 id, 把上面要删除的id ,从用户已读字段去了
        $nucm = new NoticeUserC();

        foreach($list['data'] as $v)
        {
            $arr_id = $v['nuu_id'] != null ? json_decode($v['nuu_id']) : [];
            $data = array_diff($arr_id, $arr['data']);
            sort($data);
            $nucm->edit(['id'=>$v['id'], 'nuu_id'=>json_encode($data)]);
        }

        // 删除信息id
        $num->del($arr['data']);
    }

    /**
     * 每日 00:00:00
     * 红包到期
     */
    private function red_exp()
    {
        $rem = new RedEnvelopes();
        $reum = new RedEnvelopesUser();
        $res = $rem->getList(0, 0, [], 'id, expiration_time');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        foreach($res['data'] as $v)
        {
            if($v['expiration_time'] == date('Y-m-d', time())){
                // 删除红包信息
                $rem->del($v['id']);
                // 删除关系表的信息
                $reum->delWhere(['r_id'=>$v['id']]);
            }
        }
    }

    /**
     * 当前月,计算上月后援会广告分成分成
     */
    private function up_backup()
    {

    }

    /**
     * 每月1号清除,商品投票关系表
     */
    public function vote()
    {
        db('UnionVote')->where(['status'=>0])->update(['status'=>1]);
        db('UnionVoteLog')->where('1=1')->delete();
    }
}
