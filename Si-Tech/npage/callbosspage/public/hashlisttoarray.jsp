<%!
    public  String[][] getArrayFromListMap(java.util.List inputList,int size){
		if(inputList==null||inputList.size()==0){
			return new String[0][0];
		}
		String[][] result_ = new String[inputList.size()][size];
		int i=0;
		for(java.util.Iterator it = inputList.iterator();it.hasNext();){
			java.util.HashMap map = (java.util.HashMap)it.next();
			String[] o = new String[size];
			int j=0;
			for(java.util.Iterator its = map.values().iterator();its.hasNext();){
				String value = "";
				Object oo = (Object)its.next();
				if(oo!=null){
					value = oo.toString();
				}
				if(value==null){
					value = "";
				}
				o[j] = value;
				j++;
			}
			result_[i] = o;
			i++;
		}
		return result_;
	} 
	public  String[][] getArrayFromListMap(java.util.List inputList,int begin_idx,int size){
		if(inputList==null||inputList.size()==0){
			return new String[0][0];
		}
		String[][] result_ = new String[inputList.size()][size];
		int i=0;
		for(java.util.Iterator it = inputList.iterator();it.hasNext();){
			java.util.HashMap map = (java.util.HashMap)it.next();
			String[] o = new String[size];
			int j=0;
			int mapflag =0;
			for(java.util.Iterator its = map.values().iterator();its.hasNext();){
				String value = "";
				if(mapflag<begin_idx){
					 Object oot = (Object)its.next();
					 mapflag++;
					 continue;
				}else if(mapflag>=begin_idx+size){
					 break;	
				}
				mapflag++;
				
				Object oo = (Object)its.next();				
				if(oo!=null){
					value = oo.toString();
				}
				if(value==null){
					value = "";
				}
				o[j] = value;
				j++;
			}
			result_[i] = o;
			i++;
		}
		return result_;
	} 
	public void writeOptions(String sql,JspWriter out_){
	try{
		List iOptionList =(List)KFEjbClient.queryForList("selectPublicArray",sql);
		String[][] queryList = getArrayFromListMap(iOptionList,2);
		for(int i=0;i<queryList.length;i++){
			out_.println("<option value='"+queryList[i][0]+"'>"+queryList[i][1]+"</option>");
		}   	
		}catch(Exception e){
		
		}	
  }
%>

	
