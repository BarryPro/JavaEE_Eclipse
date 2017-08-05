package com.belong.common;

import com.belong.model.ClassifyConfig;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.StandardChartTheme;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;

import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

/**
 * @Description: <p>用于处理图表的信息</p>
 * @Author: belong.
 * @Date: 2017/5/18.
 */
public class Chart {

    public static File generateChart(Map map) {
        // 声明主题来设置图表的字体和颜色，防止中文乱码
        StandardChartTheme chartTheme = new StandardChartTheme("CN");
        Font font = new Font("黑体", Font.BOLD, 10);
        // 设置轴向的字体
        chartTheme.setLargeFont(font);
        // 设置标题的字体
        chartTheme.setExtraLargeFont(font);
        // 设置图例的字体
        chartTheme.setRegularFont(font);
        // 为图表设置主题
        ChartFactory.setChartTheme(chartTheme);
        // 用于存放图表数据
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        Object object = map.get("list");
        ArrayList<ClassifyConfig> list = (ArrayList<ClassifyConfig>) object;
        for (ClassifyConfig config : list) {
            dataset.addValue(Integer.parseInt(config.getPager()),config.getTypeName(),config.getTypeName());
        }
        JFreeChart mChart = ChartFactory.createBarChart(
                "网站中电影中类的分布",//图名字
                "视频种类",//横坐标
                "数量(网页数)",//纵坐标
                dataset,//数据集
                PlotOrientation.VERTICAL,
                true, // 显示图例
                true, // 采用标准生成器
                true);// 是否生成超链接

        CategoryPlot mPlot = (CategoryPlot)mChart.getPlot();
        mPlot.setBackgroundPaint(Color.LIGHT_GRAY);
        mPlot.setRangeGridlinePaint(Color.BLUE);//背景底部横虚线
        mPlot.setOutlinePaint(Color.RED);//边界线

        //ChartFrame mChartFrame = new ChartFrame("柱状图", mChart);
        //mChartFrame.pack();
        //mChartFrame.setVisible(true);

        // 得到存储图片的路径
        String path = Chart.class.getClassLoader().getResource(Config.OUT_IMG).getPath();
        File file = new File(path);
        try {
            // 把图片写入文件
            ChartUtilities.saveChartAsJPEG(file,mChart,1000,600);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return file;
    }

}
