package com.belong.demo;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.StandardChartTheme;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.labels.ItemLabelAnchor;
import org.jfree.chart.labels.ItemLabelPosition;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.IntervalMarker;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.LineAndShapeRenderer;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.ui.Layer;
import org.jfree.ui.LengthAdjustmentType;
import org.jfree.ui.TextAnchor;

import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.util.Random;

/**
 * @Description: <p>图表练习</p>
 * @Author: belong.
 * @Date: 2017/5/11.
 */
public class BloodSugarChart {

    public BloodSugarChart() {
        this.createChart();
    }

    // 获得数据集 （这里的数据是为了测试我随便写的一个自动生成数据的例子）
    public DefaultCategoryDataset createDataset() {

        DefaultCategoryDataset linedataset = new DefaultCategoryDataset();
        // 曲线名称
        String series = "血糖值";  // series指的就是报表里的那条数据线
        //因此 对数据线的相关设置就需要联系到serise
        //比如说setSeriesPaint 设置数据线的颜色

        // 横轴名称(列名称)
        String[] time = new String[15];
        String[] timeValue = {"6-1日", "6-2日", "6-3日", "6-4日", "6-5日", "6-6日",
                "6-7日", "6-8日", "6-9日", "6-10日", "6-11日", "6-12日", "6-13日",
                "6-14日", "6-15日"};
        for (int i = 0; i < 15; i++) {
            time[i] = timeValue[i];
        }
        //随机添加数据值
        for (int i = 0; i < 15; i++) {
            Random r = new Random();
            linedataset.addValue(i + i * 9.34 + r.nextLong() % 100,  //值
                    series,  //哪条数据线
                    time[i]); // 对应的横轴
        }

        return linedataset;
    }

    // 生成图标对象JFreeChart
    /*
    *整个大的框架属于JFreeChart
    *坐标轴里的属于 Plot 其常用子类有：CategoryPlot, MultiplePiePlot, PiePlot , XYPlot
    */
    public void createChart() {
        // 不设置一下可能会产生乱码
        //创建主题样式
        StandardChartTheme standardChartTheme = new StandardChartTheme("CN");
        //设置标题字体
        standardChartTheme.setExtraLargeFont(new Font("隶书", Font.BOLD, 20));
        //设置图例的字体
        standardChartTheme.setRegularFont(new Font("宋书", Font.PLAIN, 15));
        //设置轴向的字体
        standardChartTheme.setLargeFont(new Font("宋书", Font.PLAIN, 15));
        //应用主题样式
        ChartFactory.setChartTheme(standardChartTheme);
        try {
            //定义图标对象
            JFreeChart chart = ChartFactory.createLineChart(null,// 报表题目，字符串类型
                    "采集时间", // 横轴
                    "血糖值", // 纵轴
                    this.createDataset(), // 获得数据集
                    PlotOrientation.VERTICAL, // 图标方向垂直
                    true, // 显示图例
                    false, // 不用生成工具
                    false // 不用生成URL地址
            );
            //整个大的框架属于chart  可以设置chart的背景颜色
            // 生成图形
            CategoryPlot plot = chart.getCategoryPlot();
            // 图像属性部分
            plot.setBackgroundPaint(Color.white);
            plot.setDomainGridlinesVisible(true);  //设置背景网格线是否可见
            plot.setDomainGridlinePaint(Color.BLACK); //设置背景网格线颜色
            plot.setRangeGridlinePaint(Color.GRAY);
            plot.setNoDataMessage("没有数据");//没有数据时显示的文字说明。
            // 数据轴属性部分
            NumberAxis rangeAxis = (NumberAxis) plot.getRangeAxis();
            rangeAxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
            rangeAxis.setAutoRangeIncludesZero(true); //自动生成
            rangeAxis.setUpperMargin(0.20);
            rangeAxis.setLabelAngle(Math.PI / 2.0);
            rangeAxis.setAutoRange(false);
            // 数据渲染部分 主要是对折线做操作
            LineAndShapeRenderer renderer = (LineAndShapeRenderer) plot
                    .getRenderer();
            renderer.setBaseItemLabelsVisible(true);
            renderer.setSeriesPaint(0, Color.black);    //设置折线的颜色
            renderer.setBaseShapesFilled(true);
            renderer.setBaseItemLabelsVisible(true);
            renderer.setBasePositiveItemLabelPosition(new ItemLabelPosition(
                    ItemLabelAnchor.OUTSIDE12, TextAnchor.BASELINE_LEFT));
            renderer
                    .setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
            /*
            *这里的StandardCategoryItemLabelGenerator()我想强调下：当时这个地*方被搅得头很晕，Standard**ItemLabelGenerator是通用的 因为我创建*的是CategoryPlot   所以很多设置都是Category相关
            *而XYPlot  对应的则是 ： StandardXYItemLabelGenerator
            */
            //对于编程人员  这种根据一种类型方法联想到其他类型相似方法的思
            //想是必须有的吧！目前只能慢慢培养了。。
            renderer.setBaseItemLabelFont(new Font("Dialog", 1, 14));  //设置提示折点数据形状
            plot.setRenderer(renderer);
            //区域渲染部分
            double lowpress = 4.5;
            double uperpress = 8;   //设定正常血糖值的范围
            IntervalMarker inter = new IntervalMarker(lowpress, uperpress);
            inter.setLabelOffsetType(LengthAdjustmentType.EXPAND); //  范围调整——扩张
            inter.setPaint(Color.LIGHT_GRAY);// 域顏色

            inter.setLabelFont(new Font("SansSerif", 41, 14));
            inter.setLabelPaint(Color.RED);
            inter.setLabel("正常血糖值范围");    //设定区域说明文字
            plot.addRangeMarker(inter, Layer.BACKGROUND);  //添加mark到图形   BACKGROUND使得数据折线在区域的前端

            // 创建文件输出流
            File fos_jpg = new File("D://bloodSugarChart.jpg ");
            // 输出到哪个输出流
            ChartUtilities.saveChartAsJPEG(fos_jpg, chart, // 统计图表对象
                    700, // 宽
                    500 // 高
            );

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //测试类
    public static void main(String[] args) {
        BloodSugarChart my = new BloodSugarChart();
    }

}
