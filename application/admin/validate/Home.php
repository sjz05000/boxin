<?php

namespace app\common\validate;

use think\Validate;

class Home extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
	protected $rule = [
        'user_id' => 'require|number',
        'type'    => 'require|number',
        'city'    => 'require',
        'page'    => 'require|number',
        'limit'   => 'require|number',
        // 'search_content' => 'require',
        'id'      => 'require|number',
        'union_type' => 'require|number',
        'union_class' => 'require|number',
        'union_id'=> 'require|number',
        'class_id'=> 'require|number',
        'one_id'  => 'require|number',
        'two_id'  => 'require|number',
        'status'  => 'require|in:1,2',
    ];
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message = [
        'user_id.require' => '用户id必填',
        'user_id.number'  => '用户id必须数字',
        'type.require'    => '缺少参数type',
        'type.number'     => '参数type必须数字',
        'city.require'    => '城市位置必填',
        'page.require'    => '页数必填',
        'page.number'     => '页数必须整数',
        'limit.require'   => '条数必填',
        'limit.number'    => '条数必须整数',
        // 'search_content.require' => '搜索内容不能为空',
        'id.require'      => '缺少参数id',
        'id.number'       => '参数id必须数字',
        'union_type.require' => '联盟分类必填',
        'union_type.number'  => '联盟分类必为数字',
        'union_class.require' => '联盟类别必填',
        'union_class.number'  => '联盟类别必为数字',
        'union_id.require' => '联盟id必填',
        'union_id.number'  => '联盟id必为数字',
        'class_id.require' => '类别参数必填',
        'class_id.number'  => '商品分类参数必为数字',
        'one_id.require'   => '缺少参数one_id',
        'one_id.number'    => '参数one_id必须数字',
        'two_id.require'   => '缺少参数two_id',
        'two_id.number'    => '参数two_id必须数字',
        'status.require'   => '参数status必填',
        'status.in'        => '参数status不在给定值内',
    ];

    /**
     * 验证场景
     */
    protected $scene = [
        'search'        => ['city', 'page', 'limit'],
        'goods_info'    => ['id'],
        'red_money'     => ['page', 'limit'],
        'alliance_card' => ['page', 'limit', 'type'],
        'use_rules'     => ['type'],
        'qr_code'       => ['id'],
        'union_code_list' => ['page', 'limit', 'type'],
        'union_column'  => ['page', 'limit', 'union_type', 'union_class', 'status'],
        'union_info'    => ['id'],
        'union_shop'    => ['id'],
        'union_business_list' => ['page', 'limit', 'union_id', 'class_id', 'status'],
        'business_class' => ['type', 'union_id'],
        'union_business_info' => ['id'],
        'union_class'    => ['type', 'status'],
        'commodity_class'=> ['id'],
        'platform_two'   => ['id', 'city'],
        'platform_search' => ['page', 'limit', 'one_id', 'two_id'],
        'commodity_search'=> ['page', 'limit', 'id', 'type', 'class_id','union_id'],
        'collection_store'=> ['id'],
        'card_info'       => ['union_id'],
        'generate_order'  => ['union_id'],
        'purchase_card'   => ['id'],
    ];
}
