<?php

namespace app\common\validate;

use think\Validate;

class News extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
	protected $rule = [
        'page'    => 'require|number',
        'limit'   => 'require|number',
        'type'    => 'require|number',
        'id'      => 'require|number',
    ];
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message = [
        'page.require'    => '页数必填',
        'page.number'     => '页数必须整数',
        'limit.require'   => '条数必填',
        'limit.number'    => '条数必须整数',
        'type.require'    => '缺少参数type',
        'type.number'     => '参数type必须数字',
        'id.require'      => '缺少参数id',
        'id.number'       => '参数id必须数字',
    ];

    /**
     * 验证场景
     */
    protected $scene = [
        'notice_list'   => ['page', 'limit', 'type'],
        'notice_info'   => ['id', 'type'],
    ];
}
