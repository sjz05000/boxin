<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件

use Qiniu\Storage\UploadManager;
use Qiniu\Auth;

use think\Db;

/***
 *  前台七牛云上传,获取token
 */
function qiniutoken()
{
    
    $config = config('app.qiniu');
    $qiniu = new Auth($config['accessKey'], $config['secretKey']);
    $expiration_time = 300;  // 过期时间 单位:秒  现在是5分钟
    $info = [
        // 'mimeLimit' => 'image/jpeg;image/png;video/mp4;',
        // 'fsizeLimit' => 512000 * 1000,  // 限定上传文件大小最大值  现在是500m
        'fsizeLimit' => 51200 * 1000,  // 限定上传文件大小最大值  现在是50m
        'mimeLimit'=>'image/*;application/pdf;video/mp4',  // 限定用户上传的文件类型
        // 'returnBody' => '{"code":200,"msg":"success","data":{"src": "' . $config['cdnUrl'] . '$(key)' . '"}}',
        'returnBody' => '{"code":0,"msg":"上传成功","data": $(key) }',
    ];
    $token = $qiniu->uploadToken($config['bucket'], null, $expiration_time, $info, true);
    return $token;
}

/***
 *  七牛删除 
 */
function qiniu_del($path)
{
    $qiniu = config('app.qiniu');
    $accessKey = $qiniu['accessKey'];
    $secretKey = $qiniu['secretKey'];
    $bucket = $qiniu['bucket'];
    $key = $path;
    $auth = new Auth($accessKey, $secretKey);
    $config = new \Qiniu\Config();
    $bucketManager = new \Qiniu\Storage\BucketManager($auth, $config);
    $res = $bucketManager->delete($bucket, $key);

}

/***
 *  后台七牛云上传 
 */
function qiniu_up($path)
{
    $config = config('app.qiniu');
    $auth = new Auth($config['accessKey'], $config['secretKey']);
    // 上传文件的本地路径
    $filePath = $path;
    $uploadMgr = new UploadManager();
    // 生成上传 Token
    $token = $auth->uploadToken($config['bucket']);
    $img = $uploadMgr->putFile($token, null, $filePath);
    $res = '';
    foreach($img as $v){
        if($v != null){
            $res = $v;
        }
    }
    return $res['key'];
}

/**
 * 本地服务器上传图片
 */
function img_up($file, $path)
{
    $info = $file->move('uploads/'.$path);
    $name = 'uploads/'.$path.'/'.$info->getSaveName();
    $imgPath = str_replace('\\','/',$name);

    return $imgPath;
}
/**
 * 本地服务器删除图片
 */
function img_del($path)
{
    @unlink($path);
}

// 发送验证码
function sendSms($phone, $code){
    $CorpID = "CDJS008664";
    $Pwd = "zm0513@";
    $Mobile = $phone;
    $Content = "您的验证码为". $code ."，该验证码在5分钟之内有效，请勿泄露。【博信巴巴】";
    $SendTime = "";
    $Sms = 1;
    header("Content-type: text/html; charset=utf-8");
    date_default_timezone_set('PRC'); //设置默认时区为北京时间
    $ContentS = rawurlencode(mb_convert_encoding($Content, "gb2312", "utf-8"));
    $url = "https://sdk2.028lk.com/sdk2/BatchSend2.aspx?";
    $curpost = "CorpID=".$CorpID."&Pwd=".$Pwd."&Mobile=".$Mobile."&Content=".$ContentS."&SendTime=".$SendTime;

    if($Sms == 1){
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // 跳过证书检查 -https
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
        curl_setopt($ch, CURLOPT_URL, $url.$curpost);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        $result = curl_exec($ch);
        curl_close($ch);
        //$result = file_get_contents($url.$curpost);
    }else if($Sms == 2){
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // 跳过证书检查 -https
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $curpost);
        $result = curl_exec($ch);
        curl_close($ch);
    }else{
        $result = 0;
    }

    return $result;
}

/**
 * 模拟get请求
 * @param string $url 请求地址
 * @return array
*/
function curl_get($url)
{
    $headers = array('User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36');
    $oCurl = curl_init();

    if (stripos($url, "https://") !== FALSE) {
        curl_setopt($oCurl, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($oCurl, CURLOPT_SSL_VERIFYHOST, FALSE);
        curl_setopt($oCurl, CURLOPT_SSLVERSION, 1); //CURL_SSLVERSION_TLSv1
    }

    curl_setopt($oCurl, CURLOPT_TIMEOUT, 20);
    curl_setopt($oCurl, CURLOPT_URL, $url);
    curl_setopt($oCurl, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($oCurl, CURLOPT_RETURNTRANSFER, 1);
    $sContent = curl_exec($oCurl);
    $aStatus = curl_getinfo($oCurl);
    curl_close($oCurl);

    if (intval($aStatus["http_code"]) == 200) {
        return $sContent;
    } else {
        return false;
    }
}

/**
 * 模拟post请求
 */
function curl_post($url, $data = array())
{
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
    // POST数据
    curl_setopt($ch, CURLOPT_POST, 1);
    // 把post的变量加上
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
    $output = curl_exec($ch);
    curl_close($ch);
    return $output;
}

// 检验手机号
function checkMobile($mobile)
{
    $ismobile = preg_match("/^1[3|4|5|6|7|8|9]\d{9}$/", $mobile);

    if($ismobile){
        return 1;
    }else{
        return 0;
    }
}

// 密码检查
function passcheck($user_pass)
{
    $num   = preg_match("/^[a-zA-Z]+$/", $user_pass);
    $word  = preg_match("/^[0-9]+$/", $user_pass);
    $check = preg_match("/^[a-zA-Z0-9]{6,12}$/", $user_pass);

    if($num || $word){
        return 2;
    }else if(!$check){
        return 0;
    }

    return 1;
}

/** 订单号 */
function getOrderNo($name = 'BX')
{
    $order_no = $name . date('Ymd'). str_pad(mt_rand(1, 99999), 5, 0, STR_PAD_LEFT);
    $res = db('order')->where(['order_no'=>$order_no])->find();
    if($res){
        getOrderNo();
    }else{
        return $order_no;
    }
}

/** 密码加密 */
function setPwd($pwd)
{
    $authcode = 'rCt52pF2cnnKNB3Hkp';
    $pass = "#>_<#" . md5(md5($authcode . $pwd));
    return $pass;
}

/**
 * 生成唯一标识 8 位
 */
function only(){
    // return mt_rand(10000000, 99999999).strrand(8);
    return mt_rand(10000000, 99999999);

}
/**
 * 随机生成数字字母.字符
 * $len 几位
*/
function strrand($len){
    $arr = array(
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
    "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v",
    "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G",
    "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R",
    "S", "T", "U", "V", "W", "X", "Y", "Z",
    );
    $arrlength = count($arr) - 1;
    $str = "";
    for ($i=0; $i<$len; $i++) {
    $str .= $arr[mt_rand(0, $arrlength)];
    }
    return $str;
}
/**
 * 要 n 位数字
 */
function strrand_number($len){
    $arr = array(
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
    );
    $arrlength = count($arr) - 1;
    $str = "";
    for ($i=0; $i<$len; $i++) {
    $str .= $arr[mt_rand(0, $arrlength)];
    }
    return (int)$str;
}


/**
 * 生成原始的二维码(生成图片文件)
 * url 内容
 * type 
 */
function scerweima($url='', $type){
    
    require_once '../extend/phpqrcode/phpqrcode.php';
	
	$value = $url;					//二维码内容
	
	$errorCorrectionLevel = 'L';	//容错级别 
	$matrixPointSize = 5;			//生成图片大小  

    switch($type){
        case 1:
            // 联盟卡推广二维码
            $dir = 'lmtg';
        break;
        case 2:
            // c 端 平台分享
            $dir = 'pttgc';
        break;
        case 3:
            $dir = '';
        break;
        case 4:
            $dir = '';
        break;
    }

    // 得有 qrcode 文件夹,在 public下 手动建一个
    if(!file_exists('qrcode/'.$dir)){
        mkdir('qrcode/'.$dir);
    }
    
	//生成二维码图片
	$filename = 'qrcode/'.$dir.'/'.time().mt_rand(100,999).'.png';
	QRcode::png($value,$filename , $errorCorrectionLevel, $matrixPointSize, 2);  
  
    // 上传到 七牛元
    // $path = qiniu_up($filename);
    // 删除 本次生成的二维码1张
    // @unlink($filename);
    // return $path;

    return $filename;
}

/**
 * 在生成的二维码中加上logo(生成图片文件)
 * url 二维码内容
 * logo 中间小图
 * path 返回的七牛元 链接
 */
function scerweima1($url='', $logo = ''){

    require_once '../extend/phpqrcode/phpqrcode.php';

    $value = $url;					//二维码内容  
	$errorCorrectionLevel = 'H';	//容错级别  
	$matrixPointSize = 6;			//生成图片大小  
	//生成二维码图片
	$filename = 'qrcode/'.time().mt_rand(100,999).'.png';
	QRcode::png($value,$filename , $errorCorrectionLevel, $matrixPointSize, 2);  
	
    if(!file_exists('qrcode')){
        mkdir('qrcode');
    }
	// $logo = 'qrcode/1.png'; 	//准备好的logo图片   
	$QR = $filename;			//已经生成的原始二维码图  
 
	if (file_exists($logo)) {   
		$QR = imagecreatefromstring(file_get_contents($QR));   		//目标图象连接资源。
		$logo = imagecreatefromstring(file_get_contents($logo));   	//源图象连接资源。
		$QR_width = imagesx($QR);			//二维码图片宽度 
		$QR_height = imagesy($QR);			//二维码图片高度   
		$logo_width = imagesx($logo);		//logo图片宽度   
		$logo_height = imagesy($logo);		//logo图片高度   
		$logo_qr_width = $QR_width / 4;   	//组合之后logo的宽度(占二维码的1/5)
		$scale = $logo_width/$logo_qr_width;   	//logo的宽度缩放比(本身宽度/组合后的宽度)
		$logo_qr_height = $logo_height/$scale;  //组合之后logo的高度
		$from_width = ($QR_width - $logo_qr_width) / 2;   //组合之后logo左上角所在坐标点
		
		//重新组合图片并调整大小
		/*
		 *	imagecopyresampled() 将一幅图像(源图象)中的一块正方形区域拷贝到另一个图像中
		 */
		imagecopyresampled($QR, $logo, $from_width, $from_width, 0, 0, $logo_qr_width,$logo_qr_height, $logo_width, $logo_height); 
	}   

    
    //输出图片
    $img = time().mt_rand(100,999).'.png';
    imagepng($QR, 'qrcode/'.$img);  
    imagedestroy($QR);
    imagedestroy($logo);

    // 上传到 七牛元  删除 本次生成的二维码2张
    $path = qiniu_up('qrcode/'.$img);
    @unlink($filename);
    @unlink('qrcode/'.$img);
    return $path;
}


/***
 *  随机昵称 
 */
function nickname()
{
    $arr = ['缥缈','羽裳','轩辕','紫萱','韶华','浮光','烟雨','蝶舞','缠绵','绝恋','碧影','星愿','落霞','忘忧',
    '幻真','翩飞','惊鸿','星月','情动','化羽','绝影','醉梦','波澜','山岚','春华','星雨','浩瀚','风萧',
    '浮波','逐风','沧澜','鸿鹄','如梦','入画','青衣','流影','舒荷','霓裳','清曲','醉月','风和','瑞雪',
    '沐宇','舞纱','夜渺','无微','晨阳','佳容','宛碧','纹香','梵音','静晓','润玉','嬛绵','明秀','归云',
    '春媱','夏露','秋颜','冬耀','缱绻','涟漪','若溪','微凉','暖阳','半夏','崖悔','洛尘','矜柔','绚烂',
    '矫情','真淳','明媚','迷离','隐忍','灼热','幻灭','落拓','锦瑟','妖娆','邪殇','离殇','恋夏'];
    return $arr[rand(0,count($arr)-1)];
}

/**
 * 生成n个元素的一数组
 */
function getDoctorNo($num, &$arr = [])
{
    $a = only();
    if(!in_array($a, $arr)){
        $arr[] = $a;
        // dump($arr);
    }

    if(count($arr) != $num){
        getDoctorNo($num,$arr);
    }
    
    // 这无法返回要的n个数据,只能返回第一个, 加上& 引用
    return $arr;
    
}

