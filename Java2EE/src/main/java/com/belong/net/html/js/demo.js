/**
 * Created by belong on 2017/4/28.
 */
function calendar(year, month,d) {
    console.log('start');
    var flag = leap_year(year);
    var months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (flag) {
        months[1] = 29
    }
    // 通过日期来进行获取星期
    var day = new Date(year, month - 1, 1);
    // 定义星期数组
    var weekDay = ["星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
    // day.getDay()是得到星期的0-6的星期表示 0表示的是星期日
    console.log(weekDay[day.getDay()]);
    var cal = document.getElementById('calendar');
    var table = document.createElement("table");
    table.setAttribute("border", "1");
    console.log(table);
    for (var i = 0; i < 7; i++) {
        var tr = document.createElement("tr");
        table.appendChild(tr);
        if (i == 0) {
            // 设置星期的头
            for (var j = 0; j < 7; j++) {
                var td = document.createElement("td");
                tr.appendChild(td);
                td.innerHTML = weekDay[j]
            }
        } else {
            // 设置日期
            var week = day.getDay();
            for (var j = 1; j <= 7; j++) {
                var td = document.createElement("td");
                tr.appendChild(td);
                // 对应的号码
                var sum = (i - 1) * 7 + (j);
                if (sum <= months[month - 1] + week && sum > week) {
                    if (sum == d + week) {
                        td.innerHTML = sum - week + "";
                        td.setAttribute("style", "color:red")
                    } else {
                        td.innerHTML = sum - week + ""
                    }
                } else {
                    td.innerHTML = " "
                }
            }
        }
    }
    cal.appendChild(table)
}
/**
 * 判断闰年
 * @param year
 * @returns {boolean}
 */
function leap_year(year) {
    if ((year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)) {
        return true;
    } else {
        return false;
    }
}

calendar(2017, 4,28);
