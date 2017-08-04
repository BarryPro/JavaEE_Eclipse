<%
/********************
*version v3.0
*开发商: si-tech
*
*update:yanpx@2001-01-28
*验证手机号码
*
********************/
%>
<%!
	boolean checkPhone(String phoneHead,HttpSession session)
	{
		if(session == null)
		{
			return false;
		}
		if(phoneHead == null || phoneHead.length() < 3)
		{
			return false;
		}

		String []phoneHeadHeadList = (String [])session.getAttribute("phoneHeadList");

		if(phoneHeadHeadList == null || phoneHeadHeadList.length == 0)
		{
			return false;
		}

		for(int i=0; i< phoneHeadHeadList.length; i++)
		{
			if(phoneHeadHeadList[i].equals(phoneHead.substring(0,3)))
			{
				return true;
			}
		}

		return false;
	}
	String PhoneHeadErrMsg;
%>
<%
	PhoneHeadErrMsg = null;
	PhoneHeadErrMsg = "请输入正确的号码，号段范围[";
	String []phoneHeadHeadList = (String[])session.getAttribute("phoneHeadList");
	for(int _i=0; phoneHeadHeadList != null && _i < phoneHeadHeadList.length; _i++)
	{
		if(_i == phoneHeadHeadList.length - 1)
		{
			PhoneHeadErrMsg += phoneHeadHeadList[_i] + "]";
		}
		else
		{
			PhoneHeadErrMsg += phoneHeadHeadList[_i] + ",";
		}
	}
	if(phoneHeadHeadList == null || phoneHeadHeadList.length <= 0)
	{
		PhoneHeadErrMsg += PhoneHeadErrMsg + "]";
	}
%>
<script type="text/javascript">
function checkPhone(phoneHead){
	var phone_head = new Array();
<%
        for(int inner=0 ; phoneHeadHeadList != null && inner< phoneHeadHeadList.length; inner++)
        {
%>
			phone_head["<%=phoneHeadHeadList[inner]%>"] = true;
<%
        }
%>
	return phone_head[phoneHead.substring(0,3)] == undefined?false:true;
}

function forMobilePhone(obj){
	var phone=obj.value.substring(0,3);

	alert(checkPhone(phone));

	return true;
}
</script>
<!--<input type="text" value="" name="phone">
<input type="button" value="test" onclick="forMobilePhone(document.all.phone);"/> -->
