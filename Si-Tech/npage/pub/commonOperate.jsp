<table width="100%" border="0" cellspacing="4" cellpadding="1">
  <TR bgcolor="#F0FAFF"> 
    <td bgcolor="#F0FAFF" align="center" >
      <input type="button" name="_submitButton" value="提 交" onclick="saveData();return false">
      <input type="reset" name="_resetButton" value="取 消">
      <input type="button" name="_closeButton" value="关 闭" onclick="cancelJob()">  
    </td>
  </tr>    
</table>

<script language="javascript">
function hideEvent()
{
   if(self.status!="")
   {
     alert("正在提交数据，请稍候！");     
	   return false;
   }
}

function cancelJob(){
	if (confirm("此操作将放弃您所输入的数据并关闭当前操作界面，确定吗？")) {
		top.window.close();	
	}
}

function saveData()
{    
  if (!submitPage())  //每个主页面都需要提供该方法
  {
    return false;
  }  
  
  return true; 
}
</script>