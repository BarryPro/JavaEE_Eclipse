/*
 * 功能: 仿照validate_pack.js
 * 版本: 1.0
 * 日期: 2013/4/19 14:40:39
 * 作者: zhangyan
 * 版权: si-tech
 * 新增: ch_name表单中文名称属性,界面提示方式改为rdShowMessageDialog
 */

/*数组元素至少一个不能为空*/
function fn_chkAllNull( a_chk )
{
	var a_len=0;
	var a_nameStr="";
	for ( var i=0 ; i<a_chk.length;i++ )
	{
		a_len=a_len+a_chk[i].value.trim().length;
		a_nameStr=a_nameStr+a_chk[i].ch_name+",";
	}
	
	if (a_len<=0)
	{
		rdShowMessageDialog( a_nameStr+"不能全部为空!" ,0);
		return 1;
	}
	return 0;
}

function fn_forInt( obj )
{
	/*为空不校验*/
	if (obj.value.trim().length==0)
	{
		return 0;
	}
	
	var patrn = /^-?\d+$/;
	var sInput = obj.value;
	if(sInput.search(patrn)==-1)
	{
		rdShowMessageDialog( obj.ch_name+"必须是数字!" ,0);
		return 1;
	}
	return 0;
}

function fn_notNull(obj)
{
	if ( obj=="undefined" )
	{
		return 0;
	}
	
	if (obj.value.trim().length==0)
	{
		rdShowMessageDialog( obj.ch_name+"不能为空!" ,0);
		return 1;
	}	
	
	if (obj.value.trim()=="$$$$$$")
	{
		rdShowMessageDialog( obj.ch_name+"必须选择!" ,0);
		return 1;
	}		
	return 0;
}

function fn_notNulls(objs)
{
	for ( var i=0;i<objs.length;i++ )
	{
		if ( objs[i]=="undefined" )
		{
			return 0;
		}

		if (objs[i].value.trim().length==0)
		{
			if ( objs[i].type=="select-one" )
			{
				rdShowMessageDialog( objs[i].ch_name+"必须选择!" ,0);
			}
			else if ( objs[i].type=="text" )
			{
				rdShowMessageDialog( objs[i].ch_name+"必须填写!" ,0);
			}

			return 1;
		}	
	}

	return 0;
} 
 