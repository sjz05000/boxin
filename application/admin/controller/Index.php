<?php
namespace app\admin\controller;

class Index extends Base
{	


	  public  function initialize()
    {
         
         parent::initialize();
       
    }

    /**
     * 后台框架首页
     */
    public function index()
    {
        return view();
    }
}
