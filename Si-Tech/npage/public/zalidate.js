/*
 * ����: ����validate_pack.js
 * �汾: 1.0
 * ����: 2013/4/19 14:40:39
 * ����: zhangyan
 * ��Ȩ: si-tech
 * ����: ch_name��������������,������ʾ��ʽ��ΪrdShowMessageDialog
 */

/*����Ԫ������һ������Ϊ��*/
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
		rdShowMessageDialog( a_nameStr+"����ȫ��Ϊ��!" ,0);
		return 1;
	}
	return 0;
}

function fn_forInt( obj )
{
	/*Ϊ�ղ�У��*/
	if (obj.value.trim().length==0)
	{
		return 0;
	}
	
	var patrn = /^-?\d+$/;
	var sInput = obj.value;
	if(sInput.search(patrn)==-1)
	{
		rdShowMessageDialog( obj.ch_name+"����������!" ,0);
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
		rdShowMessageDialog( obj.ch_name+"����Ϊ��!" ,0);
		return 1;
	}	
	
	if (obj.value.trim()=="$$$$$$")
	{
		rdShowMessageDialog( obj.ch_name+"����ѡ��!" ,0);
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
				rdShowMessageDialog( objs[i].ch_name+"����ѡ��!" ,0);
			}
			else if ( objs[i].type=="text" )
			{
				rdShowMessageDialog( objs[i].ch_name+"������д!" ,0);
			}

			return 1;
		}	
	}

	return 0;
} 
 