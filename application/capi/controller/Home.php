<?php

namespace app\capi\controller;

use think\Controller;
use app\common\controller\Base;
use app\common\model\User;
use app\common\model\UserCollection; // 用户收藏
use app\common\model\UserUnionCard;  // 用户购买联盟卡
use app\common\model\RankingList;
use app\common\model\Union;       // 联盟表
use app\common\model\UnionClass;
use app\common\model\UnionBusiness;  // 联盟内商家
use app\common\model\UnionCommodity; // 联盟商品表
use app\common\model\Star;        // 明星信息
use app\common\model\StarBackup;  // 后援会表
use app\common\model\StarBackupMember;
use app\common\model\UserSearchRecords;
use app\common\model\Business;    // 商家表
use app\common\model\PopularCities;
use app\common\model\Commodity;   // 商品表
use app\common\model\CommodityClass;

use app\common\model\RedEnvelopes;
use app\common\model\PlatformRules; // 各种平台规则

use app\common\model\Platform;    // 平台促销
use app\common\model\PlatformClass;
use app\common\model\PlatformData;
use app\common\model\PlatformClassLog;
use app\common\model\Order;
use app\common\model\MoneyLog;

use app\common\model\DivideUnionCard;

use app\common\model\ShareUnionCard;
use app\common\model\SharePlatform;
use app\common\model\UserQrcode;
// use app\common\model\;
// use app\common\model\;
// use app\common\model\;
// use app\common\model\;
use think\Db;
use think\db\Expression;


// 首页 接口
class Home extends Base
{
    /**
     * 搜索
     */
    public function search()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.search');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 添加浏览城市记录  只保留3个
        $look_log  = new UserSearchRecords();
        $log = ['type'=>1, 'user_id'=>$this->user_id, 'content'=>$this->param['city']];
        $is_log = $look_log->getInfo($log);
        if($is_log['code'] != 200){
            $res_look_log = $look_log->add($log);
        }
        $look_log_count = $look_log->getCount(['type'=>1, 'user_id'=>$this->user_id])['data'];
        if($look_log_count > 3){
            $id = $look_log->getInfo(['type'=>1, 'user_id'=>$this->user_id], 'id','id')['data']['id'];
            $look_log->del($id);
        }

        // 添加搜索记录  只保留5个
        $log = ['type'=>2, 'user_id'=>$this->user_id, 'content'=>$this->param['search_content']];
        $is_log = $look_log->getInfo($log);
        if($is_log['code'] != 200){
            $res_look_log = $look_log->add($log);
        }
        $look_log_count = $look_log->getCount(['type'=>2, 'user_id'=>$this->user_id])['data'];
        if($look_log_count > 5){
            $id = $look_log->getInfo(['type'=>2, 'user_id'=>$this->user_id], 'id','id')['data']['id'];
            $look_log->del($id);
        }

        // 搜索结果
        $commodityModel = new Commodity();  // 商品表
        $where[] = ['c.status','=',1];
        $where[] = ['c.title','like','%'.$this->param['search_content'].'%'];
        $where[] = ['b.address','like','%'.$this->param['city'].'%'];
        $limit = $this->param['page'] .','. $this->param['limit'];

        $res = $commodityModel->position_goods($where, $limit);
        foreach($res as &$v){
            // 只显示一张图
            $v['title_img'] = config('app.qiniu.cdnUrl').json_decode($v['title_img'])[0];
            // 显示全部5张图
            // $v['title_img'] = json_decode($v['title_img']);
            // foreach($v['title_img'] as &$vv)
            // {
            //     $vv = config('app.qiniu.cdnUrl').$vv;
            // }
        }
        $this->result($res, 200, '获取数据成功');
    }

    /**
     * 现阶段
     * 商品详情
     */
    public function goods_info()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.goods_info');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $commodityModel = new Commodity();
        $goods_info = $commodityModel->getInfo(['id'=>$this->param['id']], 'id, type, c_id, title, title_img, details, original_price,original_price, favorable_price');
        if($goods_info['code'] != 200){
            $this->result([], 400, $goods_info['msg']);
        }

        //添加商品分类,到浏览记录,形成推荐推荐信息
        $log  = new UserSearchRecords();
        $goods_cid = $log->getInfo(['user_id'=>$this->user_id, 'type'=>3],'id');
        if($goods_cid['code'] != 200){
            $log->add(['user_id'=>$this->user_id, 'type'=>3, 'content'=>$goods_info['data']['c_id']]);
        }else{
            $log->edit(['id'=>$goods_cid['data']['id'], 'content'=>$goods_info['data']['c_id']]);
        }

        $this->result($goods_info['data'], 200, '获取数据成功');
    }

    /**
     * 搜索的商品记录
     */
    public function search_log()
    {
        $good_log  = new UserSearchRecords();
        $search_log = $good_log->getCol(['user_id'=>$this->user_id, 'type'=>2], 'content');
        if($search_log['code'] != 200){
            $this->result([], 400, $search_log['msg']);
        }
        $this->result($search_log['data'], 200, '获取数据成功');
    }

    /**
     * 删除搜索的商品记录
     */
    public function search_log_del()
    {
        $look_log  = new UserSearchRecords();
        $res = $look_log->delWhere(['user_id'=>$this->user_id, 'type'=>2]);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        $this->result([], 200, '删除成功');
    }

    /**
     * 推荐商品
     */
    public function recommend_good()
    {
        $good_log  = new UserSearchRecords();
        $search_log = $good_log->getCol(['user_id'=>$this->user_id, 'type'=>3], 'content');
        if($search_log['code'] != 200){
            $this->result([], 400, $search_log['msg']);
        }

        $commodityModel = new Commodity();
        $res = $commodityModel->getList($this->param['page'], $this->param['limit'],['status'=>1, 'c_id'=>$search_log['data']], 'id, title, title_img, favorable_price, original_price');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        foreach($res['data'] as &$v)
        {
            $v['img'] = $v['title_img'][0];
            unset($v['title_img']);
        }
        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 搜索-地址选择 城市记录+热门城市
     */
    public function look_log()
    {
        // 选择城市记录
        $look_log  = new UserSearchRecords();
        $res = $look_log->getCol(['user_id'=>$this->user_id, 'type'=>1], 'content', 'id desc');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        // 热门城市记录
        $PopularCitiesModel = new PopularCities();
        $res_city = $PopularCitiesModel->getCol(['status'=>1], 'title');
        if($res_city['code'] != 200){
            $this->result([], 400, $res_city['msg']);
        }
        $data = [
            'city_log' =>$res['data'],
            'popular_cities' => $res_city['data'],
        ];
        $this->result($data, 200, '获取数据成功');

    }

    /**
     * 轮播里的排行榜
     */
    public function ranking_list()
    {
        // 实时获取
        // $sdf = new Timing();
        // $sdf->ranking_list();

        $ranklist = new RankingList();
        $list = [];
        $res = $ranklist->getList(0, 0, [], 'obj_type, obj_id', 'id');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        $unionModel = new Union();
        $userMedel = new User();
        $starb = new StarBackup();
        // 4个排行,取前三个在首页轮播图展示
        foreach($res['data'] as $v)
        {
            if($v['obj_type'] == 1){}

            switch($v['obj_type']){
                case 1 : // 明星合作商家贡献排行
                    $list['a'][] = $unionModel->getInfo(['id'=>$v['obj_id']], 'logo')['data']['logo'];
                    break;
                case 2 : // 联盟卡销量贡献排行 
                    $list['b'][] = $unionModel->getInfo(['id'=>$v['obj_id']], 'logo')['data']['logo'];
                    break;
                case 3 : // 明星所有后援会的粉丝数量排行
                    $list['c'][] = $userMedel->getInfo(['id'=>$v['obj_id']], 'head')['data']['head'];
                    break;
                case 4 : // 联盟商品销量排行
                    $list['d'][] = $unionModel->getInfo(['id'=>$v['obj_id']], 'logo')['data']['logo'];
                    break;
            }
        }
        $this->result($list, 200, '获取成功');
    }
    
    /**
     * 红包表
     */
    public function red_money()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.red_money');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $rem = new RedEnvelopes();
        $res = $rem->getList($this->param['page'], $this->param['limit'], [], 'id, title, money, expiration_time','id desc');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        $this->result($res['data'], 200, '获取成功');
    }
    /**
     * 多用接口
     * 联盟卡/码类别, 展示用户购买的联盟卡分类,没够买的不展示
     */
    public function union_card_class()
    {
        // 获取用户购买联盟卡的联盟id
        $uucm = new UserUnionCard();
        $arr = $uucm->getCol(['user_id'=>$this->user_id, 'status'=>0], 'u_id');
        if($arr['code'] != 200){
            $this->result([], 400, $arr['msg']);
        }

        $where[] = ['id','in', $arr['data']];
        $field = 'id,title';
        $res =  (new UnionClass())->getList(0, 0, $where, $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        $this->result($res['data'], 200, '获取成功');
    }

    /**
     * 联盟卡列表(用户购买线上联盟卡)
     */
    public function alliance_card()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.alliance_card');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $where[] = ['uu.status', '=', 0];
        $where[] = ['uu.user_id', '=', $this->user_id];
        $where[] = ['u.union_type', 'in', '1,3'];
        if($this->param['type'] != 0){
            $where[] = ['u.u_id', '=', $this->param['type']];
        }
        
        $res = (new UserUnionCard())->class_search($this->param['page'], $this->param['limit'], $where);

        $this->result($res, 200, '获取成功');
    }

    /**
     * 平台里各种使用规则
     */
    public function use_rules()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.use_rules');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $res = (new PlatformRules())->getInfo(['id'=>$this->param['type']], 'content');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        $this->result($res['data'], '200', '获取成功');
    }

    /**
     * 联盟码列表(用户购买线下联盟卡)
     */
    public function union_code_list()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.union_code_list');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $where[] = ['uu.status', '=', 0];
        $where[] = ['uu.user_id', '=', $this->user_id];
        $where[] = ['u.union_type', 'in', '2,3'];
        if($this->param['type'] != 0){
            $where[] = ['u.u_id', '=', $this->param['type']];
        }
        
        $res = (new UserUnionCard())->class_search($this->param['page'], $this->param['limit'], $where);

        $this->result($res, 200, '获取成功');
    }

    /**
     * 展示二维码
     */
    public function qr_code()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.qr_code');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $res = (new Union())->getInfo(['id'=>$this->param['id']], 'union_card_link');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        $this->result($res['data']['union_card_link'], '200', '获取成功');
    }

    /**
     * 联盟专栏下(商家/明星  status 1=>明星联盟  2=>商家联盟 )
     * 联盟分类
     */
    public function union_class()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.union_class');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 获取联盟有的联盟分类id
        $um = new Union();
        $arr = $um->getCol(['type'=>$this->param['status'], 'union_type'=>$this->param['type'], 'status'=>1, 'is_display'=>1], 'u_id');
        if($arr['code'] != 200){
            $this->result([], 400, $arr['msg']);
        }
        $id = array_unique($arr['data']);

        $where[] = ['id','in', $id];
        $field = 'id,title';
        $res =  (new UnionClass())->getList(0, 0, $where, $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        $this->result($res['data'], 200, '获取成功');

    }

    /**
     * 联盟专栏(商家/明星  status 1=>明星联盟  2=>商家联盟 )
     * 联盟数据列表
     */
    public function union_column()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.union_column');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $um = new Union();

        $where = [];
        // 区分商家/明星联盟  1=>明星联盟 2=>商家联盟
        $where[] = ['type', '=', $this->param['status']]; 
        $where[] = ['status', '=', 1];
        $where[] = ['is_display', '=', 1];
        
        // 1=>线上 2=>线下 3=>综合
        if($this->param['union_type'] != 0){
            $where[] = ['union_type', '=', $this->param['union_type']];
        }
        // 联盟面向范围
        if(!empty($this->param['city'])){
            $where[] = ['city', 'like', '%'.$this->param['city'].'%'];
        }
        // 联盟的类型
        if($this->param['union_class'] != 0){
            $where[] = ['u_id', '=', $this->param['union_class']];
        }
        // 搜索的联盟 关键字和联盟id
        if( !empty($this->param['search']) ){
            $where[] = ['name|only','like','%'.trim($this->param['search']).'%'];
        }

        $field = 'id, only, name, logo, union_type, u_id, union_card_name, union_card_logo, union_card_price, union_card_discount, union_card_style, business_number, create_time';

        $res = $um->getList($this->param['page'], $this->param['limit'], $where, $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        foreach($res['data'] as &$v)
        {
            $v['creation'] = date( 'Y-m-d H:i', strtotime($v['create_time']) );
            unset($v['create_time']);
        }

        $this->result($res['data'], 200, '获取数据成功');

    }

    /**
     * 联盟专栏下
     * 联盟详情
     */
    public function union_info()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.union_info');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $um = new Union();

        $field = 'id, type, only, name, logo, union_type, u_id, union_card_name, union_card_logo, union_card_price, union_card_discount, union_card_style, business_number, user_id';

        $res = $um->getInfo(['id'=>$this->param['id']], $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        // 所属明星
        $res['data']['star_name'] = '';
        if($res['data']['type'] ==1){
            $user = (new User)->getVal(['id'=>$res['data']['user_id']], 'nickname');
            if($user['code'] != 200){
                $this->result([], 400, $user['msg']);
            }
            $res['data']['star_name'] = $user['data'];
        }
        unset($res['data']['user_id']);

        // 检查当前用户是否购买联盟卡 0 没购买  1 已购买
        $is_card = (new UserUnionCard())->getInfo(['user_id'=>$this->user_id, 'u_id'=>$this->param['id'], 'status'=>0]);
        if($is_card['code'] != 200){
            $res['data']['is_card'] = 0;
        }else{
            $res['data']['is_card'] = 1;
        }

        // 添加足迹
        add_footprint(1, $this->param['id'], $this->user_id, date('Y-m-d'));

        $this->result($res['data'], 200, '获取成功');
    }

    /**
     * 联盟专栏下
     * 联盟详情
     * 购买联盟卡
     * 卡详情
     */
    public function card_info()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.card_info');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 联盟卡的信息
        $res = (new Union())->getInfo(['id'=>$this->param['union_id']], 'id, union_card_name, union_card_logo, union_card_price, union_card_discount, introduce');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        // 联盟卡使用规则
        $res['data']['rule'] = (new PlatformRules())->getVal(['id'=>1], 'content')['data'];

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 联盟专栏下
     * 联盟详情
     * 购买联盟卡
     * 生成订单
     */
    public function generate_order()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.generate_order');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 获取联盟卡信息
        $card = (new Union())->getInfo(['id'=>$this->param['union_id']], 'union_card_price, union_card_number, union_card_name, union_card_discount');
        if($card['code'] != 200){
            $this->result([], 400, $card['msg']);
        }

        $order = new order();
        $data['order_no'] = getOrderNo();
        $data['user_id'] = $this->user_id;
        $data['type'] = 2;
        $data['obj_type'] = 1;
        $data['obj_id'] = $this->param['union_id'];
        $data['money'] = $card['data']['union_card_price'];
        $data['pay_type'] = 1;
        $data['order_type'] = 3;
        $data['order_status'] = 1;

        $res = $order->add($data);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        $info = [
            'id' => $res['data'],
            'money' => $data['money'],
            'order_no' => $data['order_no'],
            'union_card_number' => $card['data']['union_card_number'],
            'union_card_name' => $card['data']['union_card_name'],
            'union_card_discount' => $card['data']['union_card_discount'],
        ];
        $this->result($info, 200, '获取数据成功');
    }

    /**
     * 联盟专栏下
     * 联盟详情
     * 购买联盟卡
     * 支付
     */
    public function purchase_card()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.purchase_card');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $om = new Order();
        // 获取订单信息
        $order_info = $om->getInfo(['id'=>$this->param['id']], 'obj_id, money, order_type');
        if($order_info['code'] != 200){
            $this->result([], 400, $order_info['msg']);
        }

        // 余额够不
        $user = new User();
        $money = $user->getVal(['id'=>$this->user_id], 'money');
        if($money['data'] < $order_info['data']['money']){
            $this->result([], 400, '余额不足请去充值');
        }

        // 修改用户余额
        $res_b = $user->setDecField(['id'=>$this->user_id], 'money', $order_info['data']['money']);
        if($res_b['code'] != 200){
            $this->result([], 400, $res_b['msg']);
        }
        
        // 更改订单
        $res_a = $om->edit(['id'=>$this->param['id'], 'pay_status'=>1]);
        if($res_a['code'] != 200){
            $this->result([], 400, $res_a['msg']);
        }

        // 修改购买的联盟卡记录
        // 获取联盟卡使用次数, 推广联盟卡的分成比例 
        $um = new Union();
        $union_info = $um->getInfo(['id'=>$order_info['data']['obj_id']],'union_card_number, union_card_divide');
        if($union_info['code'] != 200){
            $this->result([], 400, $union_info['msg']);
        }
        
        // 联盟卡购买+1
        $uucm = new UserUnionCard();
        $is_card = $uucm->getInfo(['user_id'=>$this->user_id, 'u_id'=>$order_info['data']['obj_id']], 'id,frequency, status');

        if($is_card['code'] != 200){
            // 没有购买过
            $uucm->add(['user_id'=>$this->user_id, 'u_id'=>$order_info['data']['obj_id'], 'frequency'=>$union_info['data']['union_card_number']]);
        }else{
            // 购买过该联盟卡, 次数用光否
            if($is_card['data']['status'] == 0){
                $uucm->setIncField(['id'=>$is_card['data']['id']], 'frequency', $union_info['data']['union_card_number']);
            }else{
                $uucm->edit(['id'=>$is_card['data']['id'], 'frequency'=>$union_info['data']['union_card_number'], 'status'=>0]);
            }
            
        }

        // 添加交易记录
        $res_b = (new MoneyLog())->add(['user_id'=>$this->user_id, 'order_id'=>$this->param['id'], 'money'=>$order_info['data']['money'], 'money_type'=>1, 'order_type'=>3, 'type'=>1, 'operation'=>0, 'describe'=>'购买联盟卡']);
        if($res_b['code'] != 200){
            $this->result([], 400, $res_b['msg']);
        }

        // 上级用户分成
        $sucm = new ShareUnionCard();
        $pid = $sucm->getInfo(['user_id'=>$this->user_id, 'un_id'=>$order_info['data']['obj_id']], 'pid');
        if($pid['code'] == 200){
            // 划给  上级加分成, 计算分成
            $money_z = $order_info['data']['money'] * $union_info['data']['union_card_divide'];
            (new DivideUnionCard())->add(['user_id'=>$this->user_id, 'un_id'=>$order_info['data']['obj_id'], 'money'=>$money_z]);

        }

        $this->result([], 200, '支付成功');

    }

    /**
     * 联盟专栏下
     * 商家经营分类
     */
    public function business_class()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.business_class');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 获取联盟内商家的id
        $ubm = new UnionBusiness();
        $arr = $ubm->getCol(['u_id'=>$this->param['union_id']], 'b_id');
        if($arr['code'] != 200){
            $this->result([], 400, $arr['msg']);
        }

        // 获取联盟内商家的分类id
        $bm = new Business();
        $where[] = ['is_display', '=', 1];
        $where[] = ['id', 'in', $arr['data']];
        $arr = $bm->getCol($where, 'b_id');
        if($arr['code'] != 200){
            $this->result([], 400, $arr['msg']);
        }

        // 最后的分类
        $ccm = new CommodityClass();
        $where = [];
        $where[] = ['id', 'in', $arr['data']];
        $field = 'id, title';
        $res = $ccm->getList(0, 0, $where, $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        $this->result($res['data'], 200, '获取成功');

    }

    /**
     * 联盟专栏下(商家/明星  status 1=>明星联盟  2=>商家联盟 )
     * 线上/下/综合联盟下
     * 商铺列表
     */
    public function union_business_list()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.union_business_list');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $ubm = new UnionBusiness();
        $where = [];
         // 区分商家/明星联盟 type 1=>明星联盟 2=>商家联盟
        $where[] = ['ub.type', '=', $this->param['status']];
        $where[] = ['ub.u_id', '=', $this->param['union_id']];
        $where[] = ['b.b_id', '=', $this->param['class_id']];
        $where[] = ['b.is_display', '=', 1];
        

        if(!empty($this->param['search'])){
            $where[] = ['b.name|b.only', 'like', '%'.$this->param['search'].'%'];
        }
        
        $limit = $this->param['page'] .','. $this->param['limit'];
        $res = $ubm->business_list($where,$limit);
        
        $this->result($res, 200, '获取数据成功');
    }

    /**
     * 联盟专栏下
     * 线上/下/综合联盟下
     * 商铺详情
     */
    public function union_business_info()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.union_business_info');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }
        $bm = new Business();
        $field = 'id, name, logo, only, goods_num, card_num, address, after_phone';
        $res = $bm->getInfo(['id'=>$this->param['id']], $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        // 检测用户是否收藏
        // is_collect
        $res_c = (new UserCollection())->getinfo(['user_id'=>$this->user_id, 'obj_type'=>1, 'obj_id'=>$this->param['id']]);
        if($res_c['code'] == 200){
            $res['data']['is_collect'] = 1;
        }else{
            $res['data']['is_collect'] = 0;
        }

        // 添加足迹
        add_footprint(2, $this->param['id'], $this->user_id, date('Y-m-d'));

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 联盟专栏下
     * 线上/下/综合联盟下
     * 商铺详情下
     * 商品分类
     */
    public function commodity_class()
    {

        $result = $this->validate($this->param,'app\common\validate\Home.commodity_class');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 获取商家发布的商品分类id, 
        switch($this->param['type']){
            // 商家发布到商品库分类id
            case 1:
                $cm = new Commodity();
                $where = [];
                $where[] = ['b_id', '=', $this->param['id']];
                $where[] = ['status', '=', 1];
                $where[] = ['is_display', '=', 1];
                $arr= $cm->getCol($where, 'c_id');
            break;
            // 发布到联盟的商品分类id
            case 2:
                $ucm = new UnionCommodity();
                $where = [];
                $where[] = ['u_id', '=', $this->param['union_id']];
                $where[] = ['b_id', '=', $this->param['id']];
                $arr = $ucm->getCol($where, 'c_id');
            break;
            // 发布到促销的商品分类id
            case 3:
                $pdm = new PlatformData();
                $where = []; 
                $where[] = ['b_id', '=', $this->param['id']];
                $arr = $pdm->getCol($where, 'c_id');
            break;
        }
        if($arr['code'] != 200){
            $this->result([], 400, $arr['msg']);
        }

        // 最后分类
        $ccm = new CommodityClass();
        $where = [];
        $where[] = ['id', 'in', $arr['data']];
        $field = 'id, title';
        $res = $ccm->getList(0, 0,$where, $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result($res['data'], 200, '获取成功');
    }
    
    /**
     * 联盟专栏下
     * 线上/下/综合联盟下
     * 商铺详情下
     * 商品列表/搜索
     */
    public function commodity_search()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.commodity_search');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 1=>全部商品 2=>联盟商品 3=>促销商品 
        switch($this->param['type']){
            case 1:
                $cm = new Commodity();
                $where = [];
                $where[] = ['b_id', '=', $this->param['id']];
                $where[] = ['c_id', '=', $this->param['class_id']];

                // 搜索内容
                if(!empty($this->param['search'])){
                    $where[] = ['title|only', 'like', '%'.$this->param['search'].'%'];
                }
                
                $field = 'id, title, title_img, original_price, favorable_price';
                $res = $cm->getList($this->param['page'], $this->param['limit'], $where, $field);
                if($res['code'] != 200){
                    $this->result([], 400, $res['msg']);
                }
        
                foreach($res['data'] as &$v)
                {
                    $v['img'] = $v['title_img'][0];
                    unset($v['title_img']);
                }
                $this->result($res['data'], 200, '获取数据成功');
            break;
            case 2:
                $ucm = new UnionCommodity();
                $where = [];
                $where[] = ['u_id', '=', $this->param['union_id']];
                $where[] = ['b_id', '=', $this->param['id']];
                $where[] = ['c_id', '=', $this->param['class_id']];

                // 搜索内容
                if(!empty($this->param['search'])){
                    $where[] = ['title|only', 'like', '%'.$this->param['search'].'%'];
                }

                $feild = 'cs_id, title, title_img, original_price, favorable_price';
                $res = $ucm->getList($this->param['page'], $this->param['limit'], $where, $feild);
                if($res['code'] != 200){
                    $this->result([], 400, $res['msg']);
                }
        
                foreach($res['data'] as &$v)
                {
                    $v['id'] = $v['cs_id'];
                    $v['img'] = $v['title_img'][0];
                    unset($v['title_img']);
                    unset($v['cs_id']);
                }
                $this->result($res['data'], 200, '获取数据成功');
            break;
            case 3:
                $pdm = new PlatformData();
                $where = []; 
                $where[] = ['b_id', '=', $this->param['id']];
                $where[] = ['c_id', '=', $this->param['class_id']];
                $feild = 'goods_id, title, title_img, original_price, favorable_price';
                // 搜索内容
                if(!empty($this->param['search'])){
                    $where[] = ['title|only', 'like', '%'.$this->param['search'].'%'];
                }

                $res = $pdm->getList($this->param['page'], $this->param['limit'], $where, $feild);
                if($res['code'] != 200){
                    $this->result([], 400, $res['msg']);
                }

                foreach($res['data'] as &$v)
                {
                    $v['id'] = $v['goods_id'];
                    $v['img'] = $v['title_img'][0];
                    unset($v['title_img']);
                    unset($v['goods_id']);
                }
                $this->result($res['data'], 200, '获取数据成功');
            break;
        }
        
    }

    /**
     * 联盟专栏下
     * 线上/下/综合联盟下
     * 商铺详情下
     * 商铺,明星收藏/取消
     */
    public function user_collection()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.collection_store');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $ucm = new UserCollection();

        // 1=>店铺2=>明星
        if($this->param['type'] == 1){

            $where = ['user_id'=>$this->user_id, 'obj_type'=>$this->param['type'], 'obj_id'=>$this->param['id']];

            $res = $ucm->getInfo($where,'id');
            if($res['code'] != 200){
                $res = $ucm->add($where);
                $status = 1;
            }else{
                $res = $ucm->del($res['data']['id']);
                $status = 0;
            }

        }else{

            // 检查超出收藏限制否
            $num = $ucm->getCount(['user_id'=>$this->user_id, 'obj_type'=>$this->param['type']] );
            if($num['code'] != 200){
                $this->result([], 400, $num['msg']);
            }

            // 检查已收藏否
            $where = ['user_id'=>$this->user_id, 'obj_type'=>$this->param['type'], 'obj_id'=>$this->param['id']];
            $res = $ucm->getInfo($where,'id');

            $status = 2; // 超出收藏限制

            $sm = new Star();
            $a = $sm->getInfo(['user_id'=>$this->param['id']]);
            if($a['code'] != 200){
                $sm->add(['user_id'=>$this->param['id']]);
            }
            
            if($res['code'] != 200 && $num['data'] < 6){
                $res = $ucm->add($where);
                $status = 1;
                // 明星粉丝量加1
                $sm->setIncField( ['user_id'=>$this->param['id']],  'fans_number');
            }else if($res['code'] == 200){
                $res = $ucm->del($res['data']['id']);
                $status = 0;
                // 明星粉丝量减1
                $sm->setDecField(['user_id'=>$this->param['id']], 'fans_number');
            }
        }
        
        if($status == 1){
            $this->result([], 200, '收藏成功');
        }elseif($status == 0){
            $this->result([], 200, '取消收藏');
        }else{
            $this->result([], 400, '最多收藏6个明星');
        }
    }
    
    /**
     * 首页
     * 平台促销一级分类
     */
    public function platform_one()
    {   
        $pm = new Platform();
        
        $res = $pm->getList(0, 0, ['status'=>1], 'id, title');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 首页
     * 平台促销二级分类
     */
    public function platform_two()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.platform_two');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }
        // 促销的信息/商品
        $pdm = new PlatformData();

        // 1=>促销信息 2=>促销商品
        if($this->param['type'] == 1){
            // 获取一级分类内,用户城市的二级分类id
            $where = [];
            $where[] = ['p_id', '=', $this->param['id']];
            $where[] = ['position', 'like', '%'.$this->param['city'].'%'];
            $arr = $pdm->getCol($where,  'pc_id');
            if($arr['code'] != 200){
                $this->result([], 400, $arr['msg']);
            }
            $id = array_unique($arr['data']);

            // 26英文字母排序
            $exp = new Expression('convert(title using gbk) asc');
            $pcm = new PlatformClass();
            $where = [];
            // $where[] = ['b_id', '=', $this->param['id']];
            $where[] = ['id', 'in', $id];
            $res = $pcm->where($where)->field('id, title')->order('is_recom desc')->orderRaw($exp)->limit(0,10)->select();
            $this->result($res, 200, '获取数据成功');

        }else{

            // 促销商品的分类,复用商品分类
            $type = $this->param['id'] == 3 ? 1 : 2;  // 共4个一级分类促销,3为促销线上商品 4=>
            
            // 获取所在城市商家id
            $id = (new Business())->getCol([['address', 'like', '%'.$this->param['city'].'%']], 'id');
            if($id['code'] != 200){
                $this->result([], 400, $id['msg']);
            }

            // 获取促销里的商品分类c_id
            $where = [];
            $where[] = ['p_id', '=', $this->param['id']];
            $where[] = ['type', '=', $type];
            $where[] = ['b_id', 'in', $id['data']];
            $b_arr = $pdm->getCol($where, 'c_id');
            if($b_arr['code'] != 200){
                $this->result([], 400, $b_arr['msg']);
            }
            $class_arr = array_unique($b_arr['data']);

            $res = (new CommodityClass())->getList(0, 0, [ ['id', 'in', $class_arr] ], 'id, title');
            if($res['code'] != 200){
                $this->result([], 400, $res['msg']);
            }
            $this->result($res['data'], 200, '获取数据成功');
        }
  
        
    }

    /**
     * 首页
     * 平台促销
     * 点击二级分类跳转(列表/搜索)
     */
    public function platform_search()
    {
        $result = $this->validate($this->param,'app\common\validate\Home.platform_search');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 先判断促销的是信息还是商品
        $pm = new Platform();
        $type = $pm->getVal(['id'=>$this->param['one_id']], 'type');
        if($type['code'] != 200){
            $this->result([], 400, $type['msg']);
        }

        // 1=>促销信息 2=>促销商品
        $pdm = new PlatformData();
        if($type['data'] == 1){

            $where = [];
            $where[] = ['p_id', '=', $this->param['one_id']];

            // 搜索内容, 搜索的是二级分类
            if(!empty($this->param['search'])){
                $where_log[] = ['b_id', '=', $this->param['one_id']];
                $where_log[] = ['title', 'like', '%'.$this->param['search'].'%'];
                $arr = (new PlatformClass())->getCol($where_log, 'id');
                // halt($arr);
                $where[] = ['pc_id', 'in', $arr['data']];

                // 促销平台 搜索未果记录 添加  (针对的是促销信息)
                if(empty($arr['data'])){
                    (new PlatformClassLog())->add(['b_id'=>$this->param['one_id'], 'title'=>$this->param['search']]);
                }
            }else{
                $where[] = ['pc_id', '=', $this->param['two_id']];
            }

            $field = 'id, title, logo, position, content, start_time, end_time, jump_link';
            $res = $pdm->getList($this->param['page'], $this->param['limit'], $where, $field);
            if($res['code'] != 200){
                $this->result([], 400, $res['msg']);
            }
            
        }else{

            $where = [];
            $where[] = ['p_id', '=', $this->param['one_id']];
            $where[] = ['c_id', '=', $this->param['two_id']];
            // 搜索内容
            if(!empty($this->param['search'])){
                $where[] = ['title|only', 'like', '%'.$this->param['search'].'%'];
            }
            $field = 'goods_id, title, title_img, original_price, favorable_price';
            $res = $pdm->getList($this->param['page'], $this->param['limit'], $where, $field);
            if($res['code'] != 200){
                $this->result([], 400, $res['msg']);
            }
            foreach($res['data'] as &$v)
            {
                $v['id'] = $v['goods_id'];
                $v['img'] = $v['title_img'][0];
                unset($v['title_img']);
                unset($v['goods_id']);
            }
        }
        
        $this->result($res['data'], 200, '获取数据成功');
    }


    /**
     * 二维码参数接口判断
     * 添加分享者的信息
     * 以被分享者的角度建的表
     */
    public function judge_code()
    {
        // halt($this->param);
        switch($this->param['type']){
            // 联盟卡推广二维码  LMTG+随机码+商家联盟名称+建立商家名称+消费者名称+日期+随机数
            // http://www.bx.com/capi/Home/judge_code?type=LMTG&number=174&union_id=1&shop_id=5&user_id=1&date=1636450893&number_z=241
            case 'LMTG':
                $data = [
                    'user_id'=>$this->user_id,
                    'un_id'=>$this->param['union_id']
                ];
                // 联盟卡推广记录
                $sucm = new ShareUnionCard();
                $res = $sucm->getInfo($data);
                if($res['code'] != 200){
                    $data['pid'] = $this->param['user_id'];  // 分享者id
                    $sucm->add($data);
                }else{
                    $sucm->editWhere(['pid'=>$this->param['user_id']], $data);
                }

                // 给被推广者生成一个分享联盟卡
                $uqm = new UserQrcode();
                $where = ['user_id'=>$this->user_id, 'obj_type'=>1, 'obj_id'=>$this->param['union_id']];
                $is_img = $uqm->getInfo($where);
                if($is_img['code'] != 200){
                    $url = config('app.url').'capi/Home/judge_code?type=LMTG&number='.mt_rand(100, 999).'&union_id='.$this->param['union_id'].'&shop_id='.$this->param['shop_id'].'&user_id='.$this->user_id.'&date='.time().'&number_z='.mt_rand(100, 999);

                    $img = scerweima($url,1);

                    $where['img'] = $img;
                    $uqm->add($where);
                }
                

                $this->result(['shop_id'=>$this->param['shop_id']], '200', '跳转到店铺详情(店铺id)');
            break;

            // c 端平台分享   PTTGC+随机码+日期+用户id+随机数
            // http://www.bx.com/capi/Home/judge_code?type=PTTGC&number=368&date=1636434529&user_id=1&number_z=926
            case 'PTTGC':
                // 被推广者需满足 三个月及三个月以上未登陆
                $um = new User();
                $res = $um->getInfo(['id'=>$this->user_id], 'login_time');
                if($res['code'] != 200){
                    $this->result([], 400, $res['msg']);
                }
                $login_time = strtotime("+3 month", date($res['data']['login_time']));
                if($login_time < time()){
                    $spm = new SharePlatform();
                    // 检测当前用户有无上级, 有上级不改变
                    $is_pid = $spm->getInfo(['user_id'=>$this->user_id], 'pid');
                    if($is_pid['code'] != 200){
                        $spm->add(['user_id'=>$this->user_id, 'pid'=>$this->param['user_id']]);
                        // 推广加分
                        $this->promotion_bonus($this->param['user_id']);
                    }
                }
            break;

            case '123':
            break;
        }

         
    }

    /**
     * c 端 平台推广加分
     * $id 分享者id
     */
    private function promotion_bonus($id)
    {
        // 引入的用户会为分享用户在各个后援会的排名分数中均加1分
        $res = db('StarBackupMember')
        ->alias('sb')
        ->join('StarBackup s', 'sb.s_id = s.id')
        ->where(['sb.user_id'=>$id])
        ->field('s.id')
        ->select();

        // 后援会贡献加
        foreach($res as $v)
        {
            db('StarBackup')->where(['id'=>$v['id']])->setInc('total_ranking');
        }

        // 自己的贡献加
        db('StarBackupMember')->where(['user_id'=>$id])->setInc('pull');
        db('StarBackupMember')->where(['user_id'=>$id])->setInc('contribution');
    }
}