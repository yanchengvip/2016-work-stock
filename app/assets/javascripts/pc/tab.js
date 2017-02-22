
// JavaScript Document
$(function(){
   $(".testSelect").change(function(){
    if($(".testSelect option:selected").val()==0){
    	$('.text_1').addClass('show');
    	$('.text_2').removeClass('show');
    }else{
    	$('.text_1').removeClass('show');
    	$('.text_2').addClass('show');
    }
    $('.testSelect option:selected').val();
   });


   var recTab = new myTab(".pro_deta");//标签切换
})
/* 标签切换 */
	/*
		tabclass  ： 标签切换的总容器的class
		tab_title ： 标签容器的class
		tab_body  ： 标签内容容器的class
		tab_list  ： 标签实体的class
	*/

function myTab(tabclass){
	var tab_title = $(tabclass).find(".pro_title");
	var tab_body = $(tabclass).find(".tab_body");
	var tab_listIndex = 0;
	var _this = this;
	_this.tabclass = tabclass;
	tab_title.find("a").click(function(){
		tab_listIndex =$(this).index();
		$(this).addClass("red").siblings().removeClass("red")
		tab_body.find(".tab").eq(tab_listIndex).show().siblings().hide();
		return _this.gotoAjax(tabclass,tab_listIndex);
	});
	_this.gotoAjax = function(tabclass,tab_listIndex){/* 自定义ajax事件 */}
}
