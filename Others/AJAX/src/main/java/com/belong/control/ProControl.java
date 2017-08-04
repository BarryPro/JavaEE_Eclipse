package com.belong.control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.belong.vo.City;
@WebServlet(name="/ProControl",
		urlPatterns={"/ProControl"})
public class ProControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private City hlj[] = {new City("jx","鸡西"),
			new City("jms","佳木斯"),
			new City("hg","鹤岗"),
			new City("herbin","哈尔滨"),			
	};//对象数组
	private City jl[] = {new City("cbs","长白山")
				
	};//对象数组
	private City ln[] = {new City("sy","沈阳")
	};//对象数组
	private City sc[] = {new City("cl","长流")
	};//对象数组
	private City yn[] = {new City("xgll","香格里拉")
	};//对象数组
	private City hn[] = {new City("ny","南阳")
	};//对象数组
	public ProControl() {
		// TODO Auto-generated constructor stub
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String proid = req.getParameter("proid");
		String result = "";
		switch (proid) {
		case "hlj":
			result = JSON.toJSONString(hlj);
			break;
		case "jl":
			result = JSON.toJSONString(jl);
			break;
		case "ln":
			result = JSON.toJSONString(ln);
			break;
		case "sc":
			result = JSON.toJSONString(sc);
			break;
		case "hn":
			result = JSON.toJSONString(hn);
			break;
		case "yn":
			result = JSON.toJSONString(yn);
			break;
		default:
			break;
		}
		resp.setCharacterEncoding("utf-8");
		PrintWriter out = resp.getWriter();
		out.write(result);
		out.flush();
		out.close();
	}
	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
	}

}
