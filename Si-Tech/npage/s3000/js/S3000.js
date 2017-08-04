function getInfoFromCode(flag,code){
  var info ;
  switch(flag){
    case "acntStat"://用户使用状态
	    if (code == "1")
		   info = "有效";
	    else if (code == "2")
		   info = "黑名单";
		else if (code == "3")
		   info = "头次使用";
		else if (code == "4")
		   info = "挂失";
		else if (code == "5")
		   info = "HLR激活";
	    else if (code == "6")
		   info = "生成";
		else if (code == "7")
		   info = "头次使用挂失";
		else if (code == "8")
		   info = "黑名单挂失";
		else if (code == "9")
		   info = "正在启用";
	    break;
     case "ctFlg"://呼叫查表标志
	    if (code == "0")
		   info = "不查表";
	    else if (code == "1")
		   info = "查表限制";
		else if (code == "2")
		   info = "查表允许";
	    break; 	
     case "cmFlg"://呼叫漫游标志
	    if (code == "0")
		   info = "不允许";
	    else if (code == "1")
		   info = "允许";
	    break;
     case "ciFlg"://呼入允许标志
	    if (code == "0")
		   info = "不允许";
	    else if (code == "1")
		   info = "允许";
	    break; 
    case "colmtFlg"://呼出限制状态
	    if (code == "0")
		   info = "不限制";
	    else if (code == "1")
		   info = "呼出限制";
		else if (code == "2")
		   info = "限制国内和国际长途";
		else if (code == "3")
		   info = "仅限制国际长途";
	    break;
    case "crdFlg"://充值卡状态
	    if (code == "0")
		   info = "有效";
	    else if (code == "1")
		   info = "已使";
		else if (code == "2")
		   info = "清退";
		else if (code == "3")
		   info = "生成";
		else if (code == "4")
		   info = "封闭状态";
	    break;
    case "tradeType"://充值方式
	    if (code == "1")
		   info = "预付费手机充值";
	    else if (code == "2")
		   info = "固定电话充值";
		else if (code == "3")
		   info = "非预付费手机充值";
		else if (code == "4")
		   info = "手工充值";
		else if (code == "5")
		   info = "预付费手机异地充值";
		else if (code == "6")
		   info = "预充值";
		else if (code == "A")
		   info = "PPIP电话充值";
		else if (code == "B")
		   info = "PPIP手工充值";
	    break;
    case "subState"://业务用户状态
	    if (code == "0")
		   info = "未激活";
	    else if (code == "1")
		   info = "激活";
		else if (code == "2")
		   info = "非预付费手机充值";
		else if (code == "3")
		   info = "开户未完成，数据加载到SMP";
		else if (code == "4")
		   info = "开户未完成，已加载到SCP";
	    break;

  }
  return info;
}
//分解字符串
function oneTokSelf(str,tok,loc)
  {
    var temStr=str;
    //if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
    //if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);

	var temLoc;
	var temLen;
    for(ii=0;ii<loc-1;ii++)
	{
       temLen=temStr.length;
       temLoc=temStr.indexOf(tok);
       temStr=temStr.substring(temLoc+1,temLen);
 	}
	if(temStr.indexOf(tok)==-1)
	  return temStr;
	else
      return temStr.substring(0,temStr.indexOf(tok));
  }	
  //延时控制按钮的可用性
  var subButt2;
  function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }