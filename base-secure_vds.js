var $j = jQuery.noConflict();
var phonesPlansFlashID = "phonesPlansFlash";
isMyAccountMain = false;
var isInIFrame = ( window.location != window.parent.location ) ? true : false;


var site_origin = "";
if (!window.location.origin) {
  site_origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port: '');
}
else{
    site_origin = location.origin;
}


var page_path = location.pathname;
var myaccount_base_url="";

var site_domain = location.href;
var cookie_domain = "";

if(site_domain.indexOf("sprint") != -1){
	cookie_domain = '.sprint.com';
}
else{
	cookie_domain = '.virginmobileusa.com';
}

$j(document).ready(function () {

    // Top Nav Current Section Indicators
	if( $j('.cart').length > 0 || $j('.page_cart').length > 0 ) $j('#navCart').addClass('currentTab');

	navShopBtn = $j('#navShop');
	navPlanBtn = $j('#navPlans');
	navSupportBtn = $j('#navSupport');
	mContainer = $j('#megaMenu');
	shpContent = $j('#shopMenu');
	plnContent = $j('#plansMenu');
	supContent = $j('#supportMenu');

	//Initialize Mega Nav
	navInit();
	
	if($j(".jcarousel-wrapper").length) {
		$j(".jcarousel-wrapper").jcarousel({
				scroll: 1,
				// auto : 5,
				itemVisibleInCallback: jcarousel_visibleItem,
				initCallback: jcarousel_initCallback
		});
	}
	
	//time warning message for some my account pages
	if($j('body').hasClass('time_warning')){
		if($j(".myaccount_iframe").length) {
			parent.$j('#time-warning-background').fadeIn('slow');
			parent.$j('#time-warning').fadeIn('slow');
		}
		else{
			$j('#time-warning-background').fadeIn('slow');
			$j('#time-warning').fadeIn('slow');
		}
	}

	// If this is a my account layer
	if($j(".myaccount_iframe").length) {
		// check to ensure opening in layer
		if (!isInIFrame) {
			if($j.cookie('ppt')|| $j.cookie('needs_to_cure')){
				//do nothing;
			}
			else{
			window.location.href = '/myaccount/home.do?o='+window.location.pathname;
			}
		}
		else {
			// resize layer
			$j(window).bind("load", function() {
				resizeLayer();
			});
		}
	}

	$j("input[type='text']").setupFormField();
	$j("textarea").setupFormField();
	$j("#nav li").setupHover();
	
	$j("input[type='password']").setupPasswordField();
	
	setupNavForLogin();
	
	setWrapperClicks();

	$j('form.validate').setupValidation();
	$j('.accordion').accordion(); 

	setupPanic();

	setupSBNav();

	if (jQuery.url) {
		checkForLayers();
	}
	
	tabs('.visual_tabs', '.visual_tab_item');
	tabs('.inline_tabs', '.inline_tab_item');

	setupPhoneGrid();
	setupPhoneDetail();

	updateNavForFlash();
	
	updateLinks();
	addMouseOver();
	
	checkLoggedIn();		

	$j('.dottedlinelist li').hover(function(){
		$j(this).next('.dottedline').css('background','none');
		$j(this).prev('.dottedline').css('background','none');
	},function(){
		$j(this).next('.dottedline').css('background','url(https://www.virginmobileusa.com/_img/header/medblock_dottedline.png) left top no-repeat');
		$j(this).prev('.dottedline').css('background','url(https://www.virginmobileusa.com/_img/header/medblock_dottedline.png) left top no-repeat');
	})
	
	if ($j.colorbox) {
		$j(".phone_details_overlay").colorbox({width:"900px", height: "600px", iframe:true});
		$j(".my_account_overlay").click(function() {
												 
			///this is for changing the style sheets of the color box from plain white to the gray-topped box for the my account pages
			setActiveStyleSheet(null);
			
			if (this.tagName == 'A') {
				var uri = $j(this).attr('href');
			}
			else {
				var uri = $j(this).find('a').attr('href');
			}
			$j.colorbox({
            width: "805px",
            height: "500px",
            iframe: true,
            closeButton: true,
            scrolling: false,
            href: uri,
            opacity:.5,
            onCleanup: function () {
                //alert('onCleanup: this is the href ' + uri)
            }
        });
			return false;
		})
		///this is for the go to store link on the lost/broken phone offer page
		$j('.open_store_link').colorbox({width:"50%", inline:true, href:"#popupBox"});
		
		$j(".overlay_close_handler").click(function() {
			$j.colorbox.close();
			return false;
			
		});
	}
	
    if($j.cookie)
	{
		if ($j.cookie('myaccount_base_url')){
		
		     var current_base_url_from_cookie = $j.cookie('myaccount_base_url');
			
			if(current_base_url_from_cookie.indexOf('mkb') != -1 ){ ///multiple test environments, this means that the user has already been to a my account page and the cookie has been set to one of these test server URLs
			    // myaccount_base_url = $j.cookie('myaccount_base_url');
			 }
			 else{
			      myaccount_base_url = 'https://www2.virginmobileusa.com'; ///in production, this should be ok since there's only one production environment
			                                                 /// also, in test, this means, that the base token will be used in edge cases where the user has not gone to one of the RTB test servers yet
			 }
		}
		else{
		    if(site_origin && site_origin.indexOf('mkb') != -1 ){ ///multiple test environments
	
          		$j.cookie('myaccount_base_url', site_origin, {path: '/', domain: cookie_domain});
          	}
           	else{
           		$j.cookie('myaccount_base_url', 'https://www2.virginmobileusa.com', {path: '/', domain: cookie_domain}); //defaults to base_url_prepaid token
           	}
		}
		
		myaccount_base_url = $j.cookie('myaccount_base_url');
	}
	
	// Populate Cart Counter
	// *** BORKED UNTIL IBM FIXES COOKIE ***
	//cartFill();
});




/*########################### BEGIN VMU TOP NAV #################################*/
var navShopBtn, navPlanBtn, mContainer, shpContent, plnContent, navSupportBtn, supContent;
var hoverDelay = 500;
var menuOpen = menuHovered = navShopHovered = navPlansHovered =  navSupportHovered = false;

function navDelayClose() {
	setTimeout(navClose,hoverDelay);
}

function navClose() {
	if( !menuHovered && !navShopHovered && !navPlansHovered && !navSupportHovered ) {
		mContainer.slideUp(function(){
			menuOpen = false;
		});
		$j('#vmuTop .mainNav a').removeClass('active');
	}
}

function navInit() {
	// Navigation Shop Button Hovering
	navShopBtn.hover(
		function() {
			navShopHovered = true;
			menuOpen ? shpContent.fadeIn('fast') : shpContent.show();
			menuOpen ? plnContent.fadeOut('fast') : plnContent.hide();
			menuOpen ? supContent.fadeOut('fast') : supContent.hide();
			mContainer.stop().slideDown(function() {
				menuOpen = true;
				// Fix for partially opened menu freezes
				if(mContainer.css('display') == 'block')
					mContainer.animate({height: 254});
			});
			$j('#vmuTop .mainNav a').removeClass('active');
			$j(this).addClass('active');
		},
		function() {
			navShopHovered = false;
			navDelayClose();
		});

	// Navigation Plan Button Hovering
	navPlanBtn.hover(
		function() {
			navPlansHovered = true;
			menuOpen ? shpContent.fadeOut('fast') : shpContent.hide();
			menuOpen ? plnContent.fadeIn('fast') : plnContent.show();
			menuOpen ? supContent.fadeOut('fast') : supContent.hide();
			$j('#megaMenu:animated').stop();
			mContainer.slideDown(function() {
				menuOpen = true;
				// Fix for partially opened menu freezes
				if(mContainer.css('display') == 'block')
					mContainer.animate({height: 254});
			});
			$j('#vmuTop .mainNav a').removeClass('active');
			$j(this).addClass('active');
		},
		function() {
			navPlansHovered = false;
			navDelayClose();
		});

	// Navigation Support Button Hovering
	navSupportBtn.hover(
		function() {
			navSupportHovered = true;
			menuOpen ? shpContent.fadeOut('fast') : shpContent.hide();
			menuOpen ? plnContent.fadeOut('fast') : plnContent.hide();
			menuOpen ? supContent.fadeIn('fast') : supContent.show();
			$j('#megaMenu:animated').stop();
			mContainer.slideDown(function() {
				menuOpen = true;
				// Fix for partially opened menu freezes
				if(mContainer.css('display') == 'block')
					mContainer.animate({height: 254});
			});
			$j('#vmuTop .mainNav a').removeClass('active');
			$j(this).addClass('active');
		},
		function() {
			navSupportHovered = false;
			navDelayClose();
		});

	// Navigation Mega Menu Button Hovering
	mContainer.hover(
		function(){
			menuHovered = true;
		},
		function(){
			menuHovered = false;
			navDelayClose();
		});

	$j('#navWhy').mouseenter(navClose);
	//$j('#navSupport').mouseenter(navClose);
	$j('#navCart').mouseenter(navClose);
}

function cartFill() {
	var cartCount = $j("#navCart").find("sup");
	if($j.cookie('u_cart') != null) {
		cartCount.html("(" + $j.cookie('u_cart') + ")");
	} else {
		cartCount.html("(0)");
	}
}

/*########################### END VMU TOP NAV #################################*/



/*########################### START CART PAGE PREP #################################*/
function setupCartLanding() {
	var $pc = $j("#cart_p1-input-promo_code");
	$pc.clearOnFocusPromo();
	$pc.closest(".cart-errata-promo").find("a").bind("click", function(e){
		if(!$j(this).hasClass("promoEntered")) e.preventDefault();
		$pc.val('');
		$j('#promoCodeForm').submit();
	});
}

$j.fn.clearOnFocusPromo = function(){
    return this.bind("focus", function(){
        var v = $j(this).val();
        $j(this).val( v === this.defaultValue ? '' : v );
		if(v === this.defaultValue) $j(this).closest(".cart-errata-promo").find('a').attr("class", "");
    }).bind("blur", function(){
        var v = $j(this).val();
        $j(this).val( v.match(/^\s+$|^$/) ? this.defaultValue : v );
		if(v.match(/^\s+$|^$/)) $j(this).closest(".cart-errata-promo").find('a').attr("class", "");
    }).bind("keyup", function(e){
		var v = $j(this).val();
		var c = (v.length < 0) ? "" : "promoEntered";
		$j(this).closest(".cart-errata-promo").find('a').attr("class", c);
	});
};

function check_order_quantity()
{
	if( $j("#iphoneQuantity").length > 0 )
	{
		var iphone_amount=$j("#iphoneQuantity").attr("value");
		if(iphone_amount > 2){ alert("Limit 2 iPhones per customer."); return false; }
	}
	if( $j("#gs5Quantity").length > 0 )
	{
		var gs5_amount=$j("#gs5Quantity").attr("value");
		if(gs5_amount > 2){ alert("Limit of 2 Galaxy S5 per customer."); return false; }
	}
	
	return true;
}

/*########################### END CART PAGE PREP #################################*/


function resizeLayer() {
	// get doc width/height (add a bit extra for non ie)
	//var iOffSet = ($j.browser.msie) ? 0 : 20;
	 var iOffSet = 20;
	var iW = $j(document).width();
	var iH = $j('.outer').height() + iOffSet;

	// debug: use alert below to get calc dimensions on load
	// alert("iframe: (w:" + iW + ", h:" + iH + ")");

	// adjust size
	parent.$j.colorbox.myResize(iW, iH);
}

function setupNavForLogin() {
	$j('#sign_in_overlay').hover(function () {
		$j('#nav_main4_3').addClass('hover');
		$j('#nav_main4_4').addClass('hover');
	}, function () {
		$j('#nav_main4_3').removeClass('hover');
		$j('#nav_main4_4').removeClass('hover');
	});
	
	$j('#nav_main4_3').hover(function () {
		$j('#nav_main4_4').addClass('hover');
	}, function () {
		$j('#nav_main4_4').removeClass('hover');
	});
	
	$j('#nav_main4_4').hover(function () {
		$j(this).addClass('hoverSignOut');
		$j('#nav_main4_3').addClass('hover');
	}, function () {
		$j(this).removeClass('hoverSignOut');
		$j('#nav_main4_3').removeClass('hover');
	});

	$j('.sign_in_area').hover(function () {
		if(jQuery.browser.msie == true && jQuery.browser.version == "6.0") { 
			$j('#sign_in_overlay').show().addClass('hover');
			if( $j('body').hasClass('log') ) { $j('#header').css({'marginBottom' : '1px'}); }
		} else {
		//	$j('#sign_in_overlay').slideDown('fast');
			$j('#sign_in_overlay').show().addClass('hover');
		}
 	}, function () {
		if(jQuery.browser.msie == true && jQuery.browser.version == "6.0") {
			$j('#sign_in_overlay').hide().removeClass('hover');
			if( $j('body').hasClass('log') ) { $j('#header').css({'marginBottom' : '0'}); }
		} else {
			//$j('#sign_in_overlay').slideUp('fast');
			$j('#sign_in_overlay').hide().removeClass('hover');
		}
	});

	$j('#sign_in_overlay_form').find('input').hover(function () {
		$j(this).addClass('sign_in_overlay_hover');
 	}, function () {
		$j(this).removeClass('sign_in_overlay_hover');
	}).focus(function() {
		$j(this).addClass('sign_in_overlay_focus');
	}).blur(function() {
		$j(this).removeClass('sign_in_overlay_focus');
	});
}

function initMyAccount() {

	// check for layer to auto open
	var uri = $j.url.param('o');
	if (uri) {
		$j.colorbox({width:"805px", height: "500px", iframe:true, scrolling: false, href: uri});
	}

	$j('.acct_nav').each( function() {
		expandSidenav(0, $j(this));
		var _this = $j(this)
		$j(this).find('li').bind('mouseenter', function() {
			expandSidenav($j(_this).find('li').index($j(this)), $j(this).parent());
		});
	})

	$j('#ad1').hover( function() {
		$j(this).animate({
			width: '480'
		}, 300)
		$j('#ad1_expanded').fadeIn(200);
		$j('#ad1_collapsed').fadeOut(200);
	}, function() {
		$j(this).animate({
			width: '285'
		}, 300)
		$j('#ad1_expanded').fadeOut(200);
		$j('#ad1_collapsed').fadeIn(200);
	})
	
	$j('#ad2').hover( function() {
		$j(this).animate({
			width: '522'
		}, 300)
		$j('#ad2_expanded').fadeIn(200);
		$j('#ad2_collapsed').fadeOut(200);
	}, function() {
		$j(this).animate({
			width: '345'
		}, 300)
		$j('#ad2_expanded').fadeOut(200);
		$j('#ad2_collapsed').fadeIn(200);
	})
	
	$j('table').find("tr:last").addClass('last');
	$j('ul').find('li:last').addClass('last');
	$j('ul').find('li:first').addClass('first');

};
function expandSidenav(nav_index, scope) {
	if ($j(scope).find('li').eq(nav_index).hasClass('active')) { 
		
	} else {
		// $j('.acct_nav li').unbind().removeClass('hover').find('p').hide(0);
		$j(scope).find('li').removeClass('active').find('p').hide();
		$j(scope).find('li').eq(nav_index).addClass('active').find('p').fadeIn(200, function() {
			/* $j('.acct_nav li').bind('mouseenter', function() {
				expandSidenav($j('.acct_nav li').index($j(this)));
			});*/ 
		});
	}
}


function jcarousel_initCallback(carousel) {
		$j('#carousel_control_wrapper').css('width', $j('#carousel_control_wrapper').width() + 22)
		$j('.jcarousel-prev').insertBefore('.jcarousel-control');
		$j('.jcarousel-next').insertAfter('.jcarousel-control');

		$j('.jcarousel-control a').bind('click', function() {
			carousel.scroll($j.jcarousel.intval($j(this).text()));
			return false;
		});
};
function jcarousel_visibleItem(obj) {
	$j('.jcarousel-control a').removeClass('selected').eq(obj.first - 1).addClass('selected');

};



updateNavForFlash = function() {
	if (typeof(swfobject) != 'undefined') {
		if(swfobject.hasFlashPlayerVersion("9.0.0")) { 	
			if ($j('#page_phones').length || $j('#page_plangrid').length || $j('#page_familyplangrid').length || $j('#page_deals').length) {
				$j('#nav_main1_1 a').click(function() {
					getFlashMovie(phonesPlansFlashID).updateSlider('sectionPhones');
					return false;
				});
				$j('#nav_main1_2 a').click(function() {
					getFlashMovie(phonesPlansFlashID).updateSlider('sectionPlans');
					return false;
				});
				$j('#nav_main1_3 a').click(function() {
					getFlashMovie(phonesPlansFlashID).updateSlider('sectionDeals');
					return false;
				});
			}
		}
	}
}

setupPhoneGrid = function() {
	$j('#page_phones .phone').each(function () {
		var wrapper = $j(this);
		setPrice(wrapper);
		$j(wrapper).find('select').change(function () {
			setPrice(wrapper);
		});
	});
}
setPrice = function(wrapper) {
	var selectedItem = $j(wrapper).find('select').val();
	if (selectedItem) {
		$j(wrapper).find('h4').removeClass('current');
		$j(wrapper).find('#' + selectedItem).addClass('current');
	}
}
setupPhoneDetail = function() {
	$j('.page_phonedetail #selector_wrapper').each(function () {
		var wrapper = $j(this);
		setPriceDetail(wrapper);
		$j(wrapper).find('select').change(function () {
			setPriceDetail(wrapper);
		});
	});
}
setPriceDetail = function(wrapper) {
	var selectedItem = $j(wrapper).find('select').val();
	if (selectedItem) {
		$j(wrapper).find('div.detail_prices').removeClass('current');
		$j(wrapper).find('#' + selectedItem).addClass('current');
	}
}
checkForLayers = function() {
	if (jQuery.url.param("open")) {

		var urlArray = jQuery.url.param("open").split("|");
		var destinationURL = urlArray[1].replace("_amp_","&");

		switch(urlArray[0]) {
			case "accessory":
				if (destinationURL.indexOf('?') == -1) {
					tb_show(null,destinationURL+'?height=1000&width=778&TB_iframe=true',false);
				} 
				else {
					tb_show(null,destinationURL+'&height=1000&width=778&TB_iframe=true',false);
				}
				break;
			
			case "phone": 
			case "plan":
				if (destinationURL.indexOf('?') == -1) {
					tb_show(null,destinationURL+'?height=500&width=907&TB_iframe=true',false);
				}
				else {
					tb_show(null,destinationURL+'&height=500&width=907&TB_iframe=true',false);
				}
				break;
		}
	}
	
	// if the layer's been opened directly, then redirect to its default location
	if (typeof layerDefaultPage != 'undefined') {
		if (self == self.parent) {	
			if (layerDefaultPage.indexOf('?') == -1) {
				window.location.href = layerDefaultPage + '?open=' + layerURLData;
			}
			else {
				window.location.href = layerDefaultPage + '&open=' + layerURLData;
			}
		}
	}
}


navSlide = function() {
	$j("#nav").animate({"top": "+=70px"}, 500, 'jswing', fadeContent);
}
setupPanic = function() {
	$j('#panic').click(function () {
		alert('Oh no!');
		return false;
	});
}
fadeContent = function()
{
	/*if($j.browser.msie)
		$j('#mainContent').show(0, setMainContentHeight());
	else
		$j('#mainContent').fadeIn(700, setMainContentHeight());*/
}

/*
var currheight;
window.onresize = function(){
	if(currheight != document.documentElement.clientHeight)
	{
		// alert('onresize event triggered');
		setBackgroundImageSize();
		setMainContentHeight();	
	}
	currheight = document.documentElement.clientHeight;
}

$j(window).scroll(function() {
	if(typeof document.body.style.maxHeight === "undefined") { //if IE 6
		$j("#background").css("top", $j(window).scrollTop() + "px");  // fix bg for ie6
//		$j("#header").css("top", $j(window).scrollTop() + "px"); // fix header for ie6
	}
});
*/

setupBackgroundImage = function () {

	// total number of images, names backgroundN.jpg where N is a number. ie: background2.jpg
	totalBGImages = 7;
	// alert('bam');
	$j('#background img').replaceWith('<img src="https://www.virginmobileusa.com/_img/background' + randomBackground() + '.jpg" alt="" />');
 	setBackgroundImageSize()
}

randomBackground = function () {

	//check for cookie
	if ($j.cookie) {
		if ($j.cookie('bg')) {
			return $j.cookie('bg');
		} else {
			randBG = parseInt(Math.random()*totalBGImages);
			$j.cookie('bg', randBG, {path: '/', domain: '.virginmobileusa.com'});
			return randBG;
		}
	}

}

setBackgroundImageSize = function() {

	var docHeight = $j(document).height();
	var docWidth = $j(document).width();
		
	// preserve aspect ratio
	var imgHeight = (docWidth/1024)*768;
	
	$j('#background img').css({width:docWidth,height:imgHeight,margin:"0 auto"}).show();

}

setMainContentHeight = function() {

	if($j(".myaccount_iframe").length) {
		resizeLayer();
	}

	$j('#mainContent').height('auto')
	// console.log('height() = ' + $j('#mainContent').height());		

	var docHeight = $j(document).height() - 200;
	
	if ($j('#TB_iframeContent').length > 0) {
		var thickboxHeight = $j('#TB_iframeContent').height();
//console.log('there is a thickbox that is ',thickboxHeight,'px tall');	
		if (thickboxHeight > docHeight) {
			docHeight = thickboxHeight;	
		}
	}
// console.log('docHeight = ' + docHeight);		
	var mainContentHeight = $j('#mainContent').height();
// console.log('mainContentHeight = ' + mainContentHeight);			
	if (mainContentHeight < docHeight) {
		//$j('#mainContent').height(docHeight);
		// console.log('mainContentHeight < docHeight');	
	} else {
		// console.log('! mainContentHeight < docHeight');	
		$j('#mainContent').height('auto');	
	}

// console.log('setMainContentHeight : ' + $j('#mainContent').height());	

}

setWrapperClicks = function() {

	$j('#foreground').css('opacity', '0.5');
	
	/*$j('#nav_secondary4').click(function () {
		$j('#nav_secondary4 > a').addClass('active');
		$j('#nav_secondary4').css({'z-index': '1000'});
		$j('#nav_secondary4 ul').css('display', 'block');
		if (typeof document.body.style.maxHeight != "undefined") {//if NOT IE 6
			$j('#foreground').fadeIn('slow');
		}
		return false;
	});
	$j('#nav_secondary4 ul').bind("click", function (e){
			e.stopPropagation();
	});
	$j('#nav_secondary5').bind('click', function () {
		  $j('#nav_secondary5 > a').addClass('active');
		  $j('#nav_secondary5').css({'z-index': '1000'});
		  $j('#nav_secondary5 ul').css('display', 'block');
		  $j('#nav_secondary5 ul li iframe').attr('src', 'https://sso.virginmobileusa.com/cas/login?helioView=vmu'); 
		  if (typeof document.body.style.maxHeight != "undefined") {//if NOT IE 6
			  $j('#foreground').fadeIn('slow');
		  }
		  return false;
		  window.location.href="https://www.virginmobileusa.com/myaccount/home.do";
	});
	$j('#foreground, #nav, #container').click(function () {
		$j('#nav_secondary4 > a').removeClass('active');
		$j('#nav_secondary5 > a').removeClass('active');
		$j('#nav_secondary4').css({'z-index': ''});
		$j('#nav_secondary5').css({'z-index': ''});
		$j('#nav_secondary5 ul').css('display', 'none');
		$j('#nav_secondary4 ul').css('display', 'none');
		if (typeof document.body.style.maxHeight != "undefined") {//if NOT IE 6
			$j('#foreground').fadeOut();
		}
	});*/
}

/****************** Us-vs-Them Start ******************/
function show_compare(tracking) 
{
	var customQuerystring = "";
	
	if (document.URL.indexOf("#compare") != -1)
	{
		var compare_hash = document.URL.split('#')[1]; 
		customQuerystring = "?" + compare_hash.split(":")[1];
	}
	else
	{
		customQuerystring = tracking != null && tracking != "undefined" ? tracking : "";
	}
	 
	var compare_url = "//uswhistleout.s3.amazonaws.com/public/widgets/VirginMobile/ComparisonWidget/ComparisonWidget.html" + customQuerystring;

	// If colorBox falters in IE8 or earlier uncomment the browser 
	// detect if to utilize a popup window instead.
	/*if (document.all && !document.addEventListener) 
	{*/
		window.open(compare_url,'_blank', 'width=1000,height=820,scrollbars=1,directories=0,status=0,toolbar=0,menubar=0,location=0');
	/*}
	else
	{*/
		/*$j.getScript('//www.virginmobileusa.com/_js/jquery/colorbox/jquery.colorbox.js', function(data, textStatus) 
		{
			$j.fn.colorbox({
				href: compare_url, 
				initialHeight: 850,
				innerWidth: 1000, 
				innerHeight: 850,
				iframe: true, 
				opacity: 0.8, 
				scrolling: false, 
				onComplete: function()
				{
				   $j("#cboxLoadedContent").css('padding-top','30px');
				   $j("#cboxLoadedContent").css('height','820px');
				}
			}); 
		});*/
		
		return false;  
	//} /* Uncomment if uncommenting the if..else above */
}
/****************** Us-vs-Them End ******************/

if (typeof String.prototype.trim != "function") {
  String.prototype.trim = function () {
    return this.replace(/^\s+|\s+$/g, '');
  };
}

jQuery.fn.vAlign = function() {
	return this.each(function(i){
		var ah = $j(this).height();
		var ph = $j(this).parent().height();
		var mh = (ph - ah) / 2;
		$j(this).css('margin-top', mh);
	});
};



jQuery.fn.setupFormField = function(theField) {
	return this.each(function() {
	
		// Save original value
		// $j(this).attr('originalValue',$j(this).val());
		
		// Add focus action (selecting field)
		$j(this).focus(function() {
			if ($j(this).val() == $j(this).attr('title')) {
				$j(this).val('');
			}
			else {
				$j(this).select();
			}
		});

		// Add blur action (moving off of field)
		$j(this).blur(function() {
			if ($j(this).val() == '') {
				$j(this).val($j(this).attr('title'));
			}
		});	
	});
}; 

jQuery.fn.setupPasswordField = function(theField) {
	return this.each(function() {
	
		// Add focus action (selecting field)
		$j(this).focus(function() {
			$j(this).addClass('hidepasswordlabel');
		});
		
		// Add blur action (moving off of field)
		$j(this).blur(function() {
			if ($j(this).val().length == 0) {
			$j(this).removeClass('hidepasswordlabel');
		}
		});
	
	});
}; 


jQuery.fn.setupHover = function() {
	return this.each(function() {
		$j(this).hover(
		function() {
			$j(this).addClass('hover');
		},
		function() {
			$j(this).removeClass('hover');
		});
	
	});
};

jQuery.fn.accordion = function() {

		return this.each(function() {
				//initialize
	
		$j(this).find('dd').hide();
		$j(this).find('dt.expanded').next('dd').show();
		
		$j(this).find('dt').each(function() {

			$j(this).click(
				function() {

						if ($j(this).hasClass('expanded')) {
							//$j(this).removeClass('expanded').next('dd').slideUp(300);
							$j(this).removeClass('expanded').next('dd').hide();

						} else {
							//$j(this).addClass('expanded').next('dd').slideDown(300);
							$j(this).addClass('expanded').next('dd').show();

						}
						//setMainContentHeight();

			});

		});
	
	});

};



jQuery.fn.accordion2 = function() {
	return this.each(function() {
	
		//initialize
		$j(this).find('dd').hide();
		$j(this).find('dt.expanded').next('dd').show();
		
		$j(this).find('dt').each(function() {
			$j(this).click(
			function() {
				if ($j(this).hasClass('expanded')) {
					$j(this).removeClass('expanded').next('dd').hide();
				} else {
					$j(this).addClass('expanded').next('dd').show();
				}
			});
		});
	});
}; 

jQuery.fn.setupValidation = function() {

	// $j(".validation_notice").hide();
	// $j(".validation_notice li").hide();
	
	this.submit(function() {
		// alert('submit');
		var errors = new Array();
		
		$j("input, select, textarea").removeClass("invalid");
		// passwords
		// check to see if pass1 and pass2 are long enough, then make sure they match
		
		if (($j("#password1").length > 0) && ($j("#password2").length > 0)) {
			if ( ($j("#password1").val().length < 4) || ($j("#password2").val().length < 4) || ($j("#password1").val() != $j("#password2").val()) ) {
			
				errors.push("password");
				$j("#password1").addClass("invalid");
				$j("#password2").addClass("invalid");
			
			}
		}
		
		// all other required form elements
		$j(".required").each(function() {
			// detect if it's been modified
			if ( $j(this).attr("title") == $j(this).val() || $j(this).val() == "") {
			
				// alert(this.id);
				// it hasn't, so show it's related LI
				errors.push(this.id);
				$j(this).addClass("invalid");
			}
		});
		
		// if email exists
		if ($j(".email").length > 0) {
		
			// does it have one @
			if ($j(".email").val().split("@").length == 2 ) {
				
				// does it have at least one dot in the 2nd half
				if ($j(".email").val().split("@")[1].split(".").length > 1 ) {
					
					//we're ok folks!
					
				} else {
					// alert("no dot");
					errors.push("email");
					$j(".email").addClass("invalid");
				}
			} else {
				// alert("not the right number of @'s in the address");
				errors.push("email");
				$j(".email").addClass("invalid");
			}
		}
		
		if ( errors.length > 0 ) {
			// drawErrors(errors);
			return false;
		} else {
			// alert("submitting");
			return true;
		}
	});
};

setupSBNav = function() {
	if (($j('#sbnav').length) && (typeof sbnav != "undefined")) {

		if (sbnav.length) {
			$j('#sbnav li').removeClass('current');
		}

		if (sbnav.length > 0) {
			$j('#sbnav > li').eq(sbnav[0]).addClass('current');
		}
		if (sbnav.length > 1) {
			$j('li.current ul').children('li').eq(sbnav[1]).addClass('current');//.children('a').prepend("&gt; ");
			
		}
		if (sbnav.length > 2) {
			$j('li.current li.current ul').children('li').eq(sbnav[2]).addClass('current');
		}
	}
}

setVisitor = function(type, value) {
	// get existing values
	var prospectCookieVal = $j.cookie('u_pr');
	var customerCookieVal = $j.cookie('u_cst');

	switch (type) {
		case "p":
			// set as long as there's no customer cookie
			if (customerCookieVal) {
			
				// if cookie val > 0 and value = 0, then do nothing
				if (prospectCookieVal && prospectCookieVal > 0) {
					return true;
				}
				
				// if cookie value = 1, then don't override for 4 or 7
				if (prospectCookieVal && prospectCookieVal == 1) {
					if (value != 4 && value != 7) {
						 $j.cookie('u_pr', value, {path: '/', expires: 30, domain: '.virginmobileusa.com'});
					}	
				}
				
				// otherwise, set the cookie
				else {
					 $j.cookie('u_pr', value, {path: '/', expires: 30, domain: '.virginmobileusa.com'});
				}
				
			}
						
			break;
			
		case "c":
			// delete prospect cookie
			if (prospectCookieVal) {
				$j.cookie('u_pr', null, {path: '/'});
			}
			
			// set value
			$j.cookie('u_cst', value, {path: '/', expires: 150, domain: '.virginmobileusa.com'});
			
			break;
	}
}	

tabs = function(tabs, tabItems) {
	$j(tabs + ' li').click(function() {
		$j(this).siblings().removeClass('current');
		$j(this).addClass('current');
		$j(this).parent().parent().find(tabItems).removeClass('current');
		clickedID = $j(this).find('a').attr('href');
		$j(clickedID).addClass('current');
		setMainContentHeight();
		return false;
	});
}; 


function getFlashMovie(movieName) {
	if (navigator.appName.indexOf("Microsoft") != -1) {             
		return window[movieName];         
	} 
	else {             
		return document[movieName];         
	}     
}     




updateLinks = function() {
	
	// Set the target of any links that should open in a new window
	$j("a[rel='new']").attr('target','_blank');
	
	// Any element that has the class .clickable, watch for click and take user to first href's URL.
	$j(".clickable").click(
		function () {
			var thisHref = $j(this).find('a:first');
			var destinationLink = thisHref.attr('href');

			if (thisHref.attr('target') == '_blank') {
				window.open(destinationLink);
				return false;
			}
			else if (thisHref.hasClass('thickbox')) {
				tb_show(null,destinationLink,false);					
				return false;
			}
			else {
				document.location = destinationLink;	
			}
		}
	);
}

addMouseOver = function() {
	// Format any external URLs to go through the exit interstitial
	$j(".mouseout").hover(
		function () {
			$j(this).removeClass('mouseout').addClass('mouseover');
		}, 
		function () {
			$j(this).removeClass('mouseover').addClass('mouseout');
		}
	);
}

checkLoggedIn = function() {

	if ($j.cookie || $j('body').hasClass('log_pre') || $j('body').hasClass('log_post')) {
		if ($j.cookie('u_log')) {
			cookieValue = $j.cookie('u_log');
			
			//alert(cookieValue);
			if (cookieValue == "pre") {
				$j('body').addClass('log');
				$j('body').addClass('log_pre');
			} else if (cookieValue == "post") {
				$j('body').addClass('log');
				$j('body').addClass('log_post');
			} 
		}

		// if body doesn't have the 'log' class at this point, then exit
		if (!($j('body').hasClass('log'))) {
			return;	
		}
		
		
		// Change Behavior of TopUp Nav Link
		if($j.cookie('needs_to_cure')){
		//if(needs_to_cure == "true"){
			//alert("no window");
		}
		else{
			$j('#topupNav>a').addClass('my_account_overlay');
		}
		
		if ($j('body').hasClass('log_pre')) {
			// add logout link
			$j('#logout').find('a').attr("href", myaccount_base_url + "/login/logout.do?loginRoutingInfo=http://www.virginmobileusa.com/");
			
			$j('#logout').bind('click', function () {
				$j.cookie('u_log', '', {path: '/', domain: '.virginmobileusa.com', expires: -100});
			});
		}
		else if ($j('body').hasClass('log_post')) {
			// add logout link
			$j('#logout').find('a').attr("href", "https://sso.virginmobileusa.com/cas/logout");
			
			$j('#logout').bind('click', function () {
				$j.cookie('u_log', '', {path: '/', domain: '.virginmobileusa.com', expires: -100});
			});
			
		}


	} 
}


function resizeiFrame(iframeContentHeight){

	// alert('resizeiFrame: ' + iframeContentHeight);
	$j('#TB_iframeContent').height(iframeContentHeight);

}


function awMigrationWarning(){
	
	if (confirm("IMPORTANT!\n\nIf you decide to switch to a Virgin Mobile plan, you will no longer receive 200 FREE Anytime Minutes each month.   If you leave Assurance Wireless now, you will need to re-apply if you wish to return to Assurance Wireless at a later time. Do you still wish to switch to a Virgin Mobile plan?"))
        {         

           window.location.href='/myaccount/migrationOverview.do';

        }

        else

        {         

          

        } 
}
	
	
	
	
// ***************************************************
//  MotionPoint Language Switch Code
// ***************************************************
var MP = {
<!-- mp_trans_disable_start --> 
  Version: '1.0.22',
  Domains: {'es':'espanol.virginmobileusa.com'},	
  SrcLang: 'en',
<!-- mp_trans_disable_end -->
  UrlLang: 'mp_js_current_lang',
  SrcUrl: unescape('mp_js_orgin_url'),
<!-- mp_trans_disable_start --> 	
  init: function(){
    if (MP.UrlLang.indexOf('p_js_')==1) {
      MP.SrcUrl=window.top.document.location.href;
      MP.UrlLang=MP.SrcLang;
  }
},
getCookie: function(name){
  var start=document.cookie.indexOf(name+'=');
  if(start < 0) return null;
  start=start+name.length+1;
  var end=document.cookie.indexOf(';', start);
  if(end < 0) end=document.cookie.length;
  while (document.cookie.charAt(start)==' '){ start++; }
  return unescape(document.cookie.substring(start,end));
},
setCookie: function(name,value,path,domain){
  var cookie=name+'='+escape(value);
  if(path)cookie+='; path='+path;
  if(domain)cookie+='; domain='+domain;
  var now=new Date();
  now.setTime(now.getTime()+1000*60*60*24*365);
  cookie+='; expires='+now.toUTCString();
  document.cookie=cookie;
},
switchLanguage: function(lang){
  if(lang!=MP.SrcLang){
    var script=document.createElement('SCRIPT');
    script.src=location.protocol+'//'+MP.Domains[lang]+'/'+MP.SrcLang+lang+'/?1023749632;'+encodeURIComponent(MP.SrcUrl);
	document.body.appendChild(script);
  } else if(lang==MP.SrcLang && MP.UrlLang!=MP.SrcLang){
    var script=document.createElement('SCRIPT');
    script.src=location.protocol+'//'+MP.Domains[MP.UrlLang]+'/'+MP.SrcLang+MP.UrlLang+'/?1023749634;'+encodeURIComponent(location.href);
	document.body.appendChild(script);
  }
  return false;
},
switchToLang: function(url) {
  window.top.location.href=url; 
}
<!-- mp_trans_disable_end -->	
};	

/**
*
*  Base64 encode / decode
*  http://www.webtoolkit.info/
*
**/
 
var Base64 = {
 
	// private property
	_keyStr : "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",
 
	// public method for encoding
	encode : function (input) {
		var output = "";
		var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
		var i = 0;
 
		input = Base64._utf8_encode(input);
 
		while (i < input.length) {
 
			chr1 = input.charCodeAt(i++);
			chr2 = input.charCodeAt(i++);
			chr3 = input.charCodeAt(i++);
 
			enc1 = chr1 >> 2;
			enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
			enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
			enc4 = chr3 & 63;
 
			if (isNaN(chr2)) {
				enc3 = enc4 = 64;
			} else if (isNaN(chr3)) {
				enc4 = 64;
			}
 
			output = output +
			this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) +
			this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);
 
		}
 
		return output;
	},
 
	// public method for decoding
	decode : function (input) {
		var output = "";
		var chr1, chr2, chr3;
		var enc1, enc2, enc3, enc4;
		var i = 0;
 
		input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
 
		while (i < input.length) {
 
			enc1 = this._keyStr.indexOf(input.charAt(i++));
			enc2 = this._keyStr.indexOf(input.charAt(i++));
			enc3 = this._keyStr.indexOf(input.charAt(i++));
			enc4 = this._keyStr.indexOf(input.charAt(i++));
 
			chr1 = (enc1 << 2) | (enc2 >> 4);
			chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
			chr3 = ((enc3 & 3) << 6) | enc4;
 
			output = output + String.fromCharCode(chr1);
 
			if (enc3 != 64) {
				output = output + String.fromCharCode(chr2);
			}
			if (enc4 != 64) {
				output = output + String.fromCharCode(chr3);
			}
 
		}
 
		output = Base64._utf8_decode(output);
 
		return output;
 
	},
 
	// private method for UTF-8 encoding
	_utf8_encode : function (string) {
		string = string.replace(/\r\n/g,"\n");
		var utftext = "";
 
		for (var n = 0; n < string.length; n++) {
 
			var c = string.charCodeAt(n);
 
			if (c < 128) {
				utftext += String.fromCharCode(c);
			}
			else if((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			}
			else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
 
		}
 
		return utftext;
	},
 
	// private method for UTF-8 decoding
	_utf8_decode : function (utftext) {
		var string = "";
		var i = 0;
		var c = c1 = c2 = 0;
 
		while ( i < utftext.length ) {
 
			c = utftext.charCodeAt(i);
 
			if (c < 128) {
				string += String.fromCharCode(c);
				i++;
			}
			else if((c > 191) && (c < 224)) {
				c2 = utftext.charCodeAt(i+1);
				string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
				i += 2;
			}
			else {
				c2 = utftext.charCodeAt(i+1);
				c3 = utftext.charCodeAt(i+2);
				string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
				i += 3;
			}
 
		}
 
		return string;
	}
 
}



function kill_cookies(cookies){
	
	for (ii=0;ii<arguments.length;++ii){

	if ($j.cookie(arguments[ii]))
	  {

		//delete cookie
		$j.cookie(arguments[ii], null, {path:'/', domain:site_domain});
     }
	}
}

function kill_topup_cookies(cookiename){
	 if ($j.cookie(cookiename))
	  {

		//delete cookie
		$j.cookie(cookiename, null, {path:'/', domain:'.virginmobileusa.com'});
      }
	 
}

/*These scripts are for switching style sheets on the fly*/
/*I use them in the My Account pages */

function setActiveStyleSheet(title) {
  var i, a, main;
  for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {
    if(a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("title")) {
      a.disabled = true;
      if(a.getAttribute("title") == title) a.disabled = false;
    }
  }
}

function getActiveStyleSheet() {
  var i, a;
  for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {
    if(a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("title") && !a.disabled) return a.getAttribute("title");
  }
  return null;
}

function getPreferredStyleSheet() {
  var i, a;
  for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {
    if(a.getAttribute("rel").indexOf("style") != -1
       && a.getAttribute("rel").indexOf("alt") == -1
       && a.getAttribute("title")
       ) return a.getAttribute("title");
  }
  return null;
}

function createCookie(name,value,days) {
  if (days) {
    var date = new Date();
    date.setTime(date.getTime()+(days*24*60*60*1000));
    var expires = "; expires="+date.toGMTString();
  }
  else expires = "";
  document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) {
  var nameEQ = name + "=";
  var ca = document.cookie.split(';');
  for(var i=0;i < ca.length;i++) {
    var c = ca[i];
    while (c.charAt(0)==' ') c = c.substring(1,c.length);
    if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
  }
  return null;
}

/*window.onload = function(e) {
  var cookie = readCookie("style");
  var title = cookie ? cookie : getPreferredStyleSheet();
  setActiveStyleSheet(title);
}

window.onunload = function(e) {
  var title = getActiveStyleSheet();
  createCookie("style", title, 365);
}

var cookie = readCookie("style");
var title = cookie ? cookie : getPreferredStyleSheet();
setActiveStyleSheet(title);*/
///this is a function for toggling the "update" button on pages with terms and conditions.
function read_terms(element){
	var checked_state = $j('#' + element).attr("checked");
	
	//console.log(checked_state);
	
	if(checked_state==true || checked_state=="checked"){
		//console.log(checked_state);
		document.getElementById("terms_submit").disabled = false;
		if($j("#terms_submit").hasClass('disabled')){
		    $j("#terms_submit").removeClass('disabled');
		}
	}
	else{
		document.getElementById("terms_submit").disabled = "disabled";
		if($j("#terms_submit").hasClass('btn_next')){
		    $j("#terms_submit").addClass('disabled');
		}
	}
}

//  --------------------------
//    USER ACCOUNT MIGRATION 
//  --------------------------
//  For questions regarding this code contact victor.valle@sprint.com 


//  jQuery cookie plugin minified
//(function(e,t,n){function i(e){return e}function s(e){return decodeURIComponent(e.replace(r," "))}var r=/\+/g;var o=e.cookie=function(r,u,a){if(u!==n){a=e.extend({},o.defaults,a);if(u===null){a.expires=-1}if(typeof a.expires==="number"){var f=a.expires,l=a.expires=new Date;l.setDate(l.getDate()+f)}u=o.json?JSON.stringify(u):String(u);return t.cookie=[encodeURIComponent(r),"=",o.raw?u:encodeURIComponent(u),a.expires?"; expires="+a.expires.toUTCString():"",a.path?"; path="+a.path:"",a.domain?"; domain="+a.domain:"",a.secure?"; secure":""].join("")}var c=o.raw?i:s;var h=t.cookie.split("; ");for(var p=0,d=h.length;p<d;p++){var v=h[p].split("=");if(c(v.shift())===r){var m=c(v.join("="));return o.json?JSON.parse(m):m}}return null};o.defaults={};e.removeCookie=function(t,n){if(e.cookie(t)!==null){e.cookie(t,null,n);return true}return false}})(jQuery,document)

$j(document).ready(function() {
	//console.log("base_vds_13_1.js");

	// Changes links of the top header links in the pages
	overrideNavClick("#topNavTrackOrder");
	overrideNavClick("#topNavActivate");
	overrideNavClick("#topNavTopup");
	overrideNavClick("#topNavMyAccount");
	overrideNavClick("#topNavSignOut");
	//overrideNavClick("#bottomNavContactUs");

	// Intercepts log out link and deletes the user account cookie
	//$j("#topNavSignOut").click(function() {
	//	 $j.cookie("user_account_type", null, {domain: ".virginmobileusa.com", path: "/"});
	//});

	//Intercepts the click of 'add to cart' in the phone grid page
	$j(".btn_addtocart").click(function() {
		overrideClick(this);
		return false;
	});

	//Intercepts the click of 'show cart' in the header
	$j("#navCart").click(function() {
		overrideClick(this);
		return false;
	});

	function overrideClick(linkElement) {
		var shopURL = $j(linkElement).attr("href");
		
		var newShopURL = processShopURL(shopURL);
		
		//console.log("Shop redirected to: " + newShopURL);
		document.location.href = newShopURL;
	}
	
	function overrideNavClick(linkElement) {
		var newNavURL = processNavURL($j(linkElement).attr("href"));
		//console.log(linkElement + " redirected to: " + newNavURL);
		$j(linkElement).attr("href", newNavURL);
	}

	//Intercepts the click of 'add to cart' of the phone details page
	$j(".button_add_to_cart").click(function() {
			var shopForm = $j(this).parent().parent();
			var shopURL = shopForm.attr("action");
			
			var newShopURL = processShopURL(shopURL);
			
			//console.log("Shop form redirecting to: " + newShopURL);
			shopForm.attr("action", newShopURL);
			shopForm.submit();
			return false;
	});
});

function processNavURL(navURL) {
	var currentDomain = "www1.virginmobileusa.com";
	var defaultDomain = "www2.virginmobileusa.com";
	var feaDomain = "www2.virginmobileusa.com";
	var legacyDomain = "www1.virginmobileusa.com";

	var cookieName = "user_account_type";
	var cookieValue = $j.cookie(cookieName);

	if(cookieValue == "fea") {
		return navURL.replace(currentDomain, feaDomain);
	} else {
		if(cookieValue == "legacy") {
			return navURL.replace(currentDomain, legacyDomain);
		} else {
			return navURL.replace(currentDomain, defaultDomain);
		}
	}
}function processNavURL(navURL) {
	try {
		var currentDomain = "www1.virginmobileusa.com";
		var defaultDomain = "www2.virginmobileusa.com";
		var feaDomain = "www2.virginmobileusa.com";
		var legacyDomain = "www1.virginmobileusa.com";

		var cookieName = "user_account_type";
		var cookieValue = $j.cookie(cookieName);

		if(cookieValue == "fea") {
			return navURL.replace(currentDomain, feaDomain);
		} else {
			if(cookieValue == "legacy") {
				return navURL.replace(currentDomain, legacyDomain);
			} else {
				return navURL.replace(currentDomain, defaultDomain);
			}
		}
	} catch(err) {
		return navURL;
	}
}


function processShopURL(shopURL) {
	var currentDomain = "www1.virginmobileusa.com";
	var defaultDomain = "www2.virginmobileusa.com";
	var feaDomain = "www2.virginmobileusa.com";
	var legacyDomain = "www1.virginmobileusa.com";

	var cookieName = "user_account_type";
	var cookieValue = $j.cookie(cookieName);

	if(cookieValue == "fea") {
		return shopURL.replace(currentDomain, feaDomain);
	} else {
		if(cookieValue == "legacy") {
			return shopURL.replace(currentDomain, legacyDomain);
		} else {
			return shopURL.replace(currentDomain, defaultDomain);
		}
	}
}


// Account migration code end ************************

/**
 * Copyright (c) 2005 - 2010, James Auldridge
 * All rights reserved.
 *
 * Licensed under the BSD, MIT, and GPL (your choice!) Licenses:
 *  http://code.google.com/p/cookies/wiki/License
 *
 */
var jaaulde=window.jaaulde||{};jaaulde.utils=jaaulde.utils||{};jaaulde.utils.cookies=(function(){var resolveOptions,assembleOptionsString,parseCookies,constructor,defaultOptions={expiresAt:null,path:'/',domain:null,secure:false};resolveOptions=function(options){var returnValue,expireDate;if(typeof options!=='object'||options===null){returnValue=defaultOptions;}else
{returnValue={expiresAt:defaultOptions.expiresAt,path:defaultOptions.path,domain:defaultOptions.domain,secure:defaultOptions.secure};if(typeof options.expiresAt==='object'&&options.expiresAt instanceof Date){returnValue.expiresAt=options.expiresAt;}else if(typeof options.hoursToLive==='number'&&options.hoursToLive!==0){expireDate=new Date();expireDate.setTime(expireDate.getTime()+(options.hoursToLive*60*60*1000));returnValue.expiresAt=expireDate;}if(typeof options.path==='string'&&options.path!==''){returnValue.path=options.path;}if(typeof options.domain==='string'&&options.domain!==''){returnValue.domain=options.domain;}if(options.secure===true){returnValue.secure=options.secure;}}return returnValue;};assembleOptionsString=function(options){options=resolveOptions(options);return((typeof options.expiresAt==='object'&&options.expiresAt instanceof Date?'; expires='+options.expiresAt.toGMTString():'')+'; path='+options.path+(typeof options.domain==='string'?'; domain='+options.domain:'')+(options.secure===true?'; secure':''));};parseCookies=function(){var cookies={},i,pair,name,value,separated=document.cookie.split(';'),unparsedValue;for(i=0;i<separated.length;i=i+1){pair=separated[i].split('=');name=pair[0].replace(/^\s*/,'').replace(/\s*$/,'');try
{value=decodeURIComponent(pair[1]);}catch(e1){value=pair[1];}if(typeof JSON==='object'&&JSON!==null&&typeof JSON.parse==='function'){try
{unparsedValue=value;value=JSON.parse(value);}catch(e2){value=unparsedValue;}}cookies[name]=value;}return cookies;};constructor=function(){};constructor.prototype.get=function(cookieName){var returnValue,item,cookies=parseCookies();if(typeof cookieName==='string'){returnValue=(typeof cookies[cookieName]!=='undefined')?cookies[cookieName]:null;}else if(typeof cookieName==='object'&&cookieName!==null){returnValue={};for(item in cookieName){if(typeof cookies[cookieName[item]]!=='undefined'){returnValue[cookieName[item]]=cookies[cookieName[item]];}else
{returnValue[cookieName[item]]=null;}}}else
{returnValue=cookies;}return returnValue;};constructor.prototype.filter=function(cookieNameRegExp){var cookieName,returnValue={},cookies=parseCookies();if(typeof cookieNameRegExp==='string'){cookieNameRegExp=new RegExp(cookieNameRegExp);}for(cookieName in cookies){if(cookieName.match(cookieNameRegExp)){returnValue[cookieName]=cookies[cookieName];}}return returnValue;};constructor.prototype.set=function(cookieName,value,options){if(typeof options!=='object'||options===null){options={};}if(typeof value==='undefined'||value===null){value='';options.hoursToLive=-8760;}else if(typeof value!=='string'){if(typeof JSON==='object'&&JSON!==null&&typeof JSON.stringify==='function'){value=JSON.stringify(value);}else
{throw new Error('cookies.set() received non-string value and could not serialize.');}}var optionsString=assembleOptionsString(options);document.cookie=cookieName+'='+encodeURIComponent(value)+optionsString;};constructor.prototype.del=function(cookieName,options){var allCookies={},name;if(typeof options!=='object'||options===null){options={};}if(typeof cookieName==='boolean'&&cookieName===true){allCookies=this.get();}else if(typeof cookieName==='string'){allCookies[cookieName]=true;}for(name in allCookies){if(typeof name==='string'&&name!==''){this.set(name,null,options);}}};constructor.prototype.test=function(){var returnValue=false,testName='cT',testValue='data';this.set(testName,testValue);if(this.get(testName)===testValue){this.del(testName);returnValue=true;}return returnValue;};constructor.prototype.setOptions=function(options){if(typeof options!=='object'){options=null;}defaultOptions=resolveOptions(options);};return new constructor();})();(function(){if(window.jQuery){(function($){$.cookies=jaaulde.utils.cookies;var extensions={cookify:function(options){return this.each(function(){var i,nameAttrs=['name','id'],name,$this=$(this),value;for(i in nameAttrs){if(!isNaN(i)){name=$this.attr(nameAttrs[i]);if(typeof name==='string'&&name!==''){if($this.is(':checkbox, :radio')){if($this.attr('checked')){value=$this.val();}}else if($this.is(':input')){value=$this.val();}else
{value=$this.html();}if(typeof value!=='string'||value===''){value=null;}$.cookies.set(name,value,options);break;}}}});},cookieFill:function(){return this.each(function(){var n,getN,nameAttrs=['name','id'],name,$this=$(this),value;getN=function(){n=nameAttrs.pop();return!!n;};while(getN()){name=$this.attr(n);if(typeof name==='string'&&name!==''){value=$.cookies.get(name);if(value!==null){if($this.is(':checkbox, :radio')){if($this.val()===value){$this.attr('checked','checked');}else
{$this.removeAttr('checked');}}else if($this.is(':input')){$this.val(value);}else
{$this.html(value);}}break;}}});},cookieBind:function(options){return this.each(function(){var $this=$(this);$this.cookieFill().change(function(){$this.cookify(options);});});}};$.each(extensions,function(i){$.fn[i]=this;});})(window.jQuery);}})();




