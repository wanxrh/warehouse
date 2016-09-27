/**      .----.
 *       _.'__    `.
 *   .--($)($$)---/#\
 * .' @          /###\
 * :         ,   #####
 *  `-..__.-' _.-\###/
 *        `;_:    `"'
 *      .'"""""`.
 *     /,     ,\\
 *    //  !BUG  \\
 *    `-._______.-'
 *    ___`. | .'___
 *   (______|______)
 *
 *  js浮点数精度
 *  @author:    jon
 *  @data:      2014年6月17日
 *  email: 191777962@qq.com
 *  @version:   1.0
 */

define(function(require, exports, module) {

  var mod = {};
  mod.Add = function(num1, num2) {
    var r1, r2, m;
    try {
      r1 = num1.toString().split('.')[1].length;
    } catch (e) {
      r1 = 0;
    }
    try {
      r2 = num2.toString().split(".")[1].length;
    } catch (e) {
      r2 = 0;
    }
    m = Math.pow(10, Math.max(r1, r2));
    return Math.round(num1 * m + num2 * m) / m;
  };
  // 两个浮点数相减
  mod.Sub = function(num1, num2) {
    var r1, r2, m;
    try {
      r1 = num1.toString().split('.')[1].length;
    } catch (e) {
      r1 = 0;
    }
    try {
      r2 = num2.toString().split(".")[1].length;
    } catch (e) {
      r2 = 0;
    }
    m = Math.pow(10, Math.max(r1, r2));
    n = (r1 >= r2) ? r1 : r2;
    return (Math.round(num1 * m - num2 * m) / m).toFixed(n);
  };
  // 两个浮点数两数相除
  mod.Div = function(num1, num2) {
    var t1, t2, r1, r2;
    try {
      t1 = num1.toString().split('.')[1].length;
    } catch (e) {
      t1 = 0;
    }
    try {
      t2 = num2.toString().split(".")[1].length;
    } catch (e) {
      t2 = 0;
    }
    r1 = Number(num1.toString().replace(".", ""));
    r2 = Number(num2.toString().replace(".", ""));
    return (r1 / r2) * Math.pow(10, t2 - t1);
  };
  // 两个浮点数两数相乘
  mod.Mul = function(num1, num2) {
    var m = 0,
      s1 = num1.toString(),
      s2 = num2.toString();
    try {
      m += s1.split(".")[1].length
    } catch (e) {};
    try {
      m += s2.split(".")[1].length
    } catch (e) {};
    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
  };

  module.exports = mod;

})