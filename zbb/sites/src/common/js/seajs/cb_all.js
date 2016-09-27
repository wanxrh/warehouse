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
 * 多选框全选
 * @author jon
 * @email 191777962@qq.com
 */
define(function(require, exports, moudles) {

	//引入JQ
	var $ = require("jquery");

	$.fn.checkAll = function(checkbox) { /*参数：匹配需要被选中的checkbox的选择器;*/
		var $cAll = this.eq(0),
			$cBox = $(checkbox);
		$cAll.click(function() {
			$cBox.prop("checked", $cAll.prop("checked"));
		});
		$cBox.click(function() {
			var len = $cBox.length,
				trueLen = $cBox.filter(":checked").length;
			$cAll.prop("checked", len === trueLen);
		});
	}

})