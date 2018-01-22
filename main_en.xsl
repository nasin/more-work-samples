<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp "&#160;">
<!ENTITY copy "&#469;">
<!ENTITY reg "&#174;">
<!ENTITY cent "&#162;">
<!ENTITY Ntilde  "&#241;" ><!-- small n, tilde -->
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="html" indent="yes" 
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />
	
	<!--#include virtual="../../includes/common_vds/global-nav.xsl"-->
	<!--#include virtual="../../includes/common_vds/globals-and-utilities.xsl"-->
	<!--#include virtual="../../includes/common_vds/phone-image-name-displays.xsl"-->
	<!--#include virtual="../../includes/common_vds/s_code.xsl"-->
	
	
	
	<xsl:variable name="total_monthly_charge" select="number(substring(/vmu-page/account-info/pending-plan-migration/monthly-price,2))"/>
	<xsl:variable name="total_amount_due" select="number(substring(/vmu-page/account-info/next-payment-due/total,2))"/>
	<xsl:variable name ="total_monthly_charge_blackberry">
    	<xsl:choose>
          <xsl:when test="/vmu-page/account-info/black-berry/blackberry-cost='0.00'">
          	<xsl:value-of select="$total_monthly_charge + 0.00"/>
          </xsl:when>
          <xsl:otherwise>
         	 <xsl:value-of select="$total_monthly_charge + 10.00"/>
          </xsl:otherwise>
       </xsl:choose>
    </xsl:variable>
        
	<xsl:variable name ="total_amount_due_blackberry">
    	<xsl:choose>
          <xsl:when test="/vmu-page/account-info/black-berry/blackberry-cost='0.00'">
          	<xsl:value-of select="$total_amount_due + 0.00"/>
          </xsl:when>
          <xsl:otherwise>
         	 <xsl:value-of select="$total_amount_due + 10.00"/>
          </xsl:otherwise>
       </xsl:choose>
    </xsl:variable>
    

	
	<xsl:variable name="balance_is_greater_than_plancost">
		<xsl:choose>
			<xsl:when test="$plan-type='paylo'">
				<xsl:choose>
					<xsl:when test="number(translate(/vmu-page/account-info/plan-info/total,'$','')) &lt; number(translate(/vmu-page/account-info/balance-string,'$',''))">true</xsl:when>
					<xsl:otherwise>false</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="number(translate(/vmu-page/account-info/next-payment-due/total,'$','')) &lt; number(translate(/vmu-page/account-info/balance-string,'$',''))">true</xsl:when>
					<xsl:otherwise>false</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="positive_difference_owed">
		<xsl:choose>
			<xsl:when test="$plan-type='paylo'">
			<xsl:value-of select="format-number(number(translate(/vmu-page/account-info/plan-info/total,'$','')) - number(translate(/vmu-page/account-info/balance-string,'$','')),'0.00')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="format-number(number(translate(/vmu-page/account-info/next-payment-due/total,'$','')) - number(translate(/vmu-page/account-info/balance-string,'$','')),'0.00')"/>
			</xsl:otherwise>
				
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="display-auto-top-up">
	<xsl:choose>
		<xsl:when test="$plan-cos = 'COS402' or $plan-cos = 'COS405' or $plan-cos = 'COS199' or $plan-cos = 'COS20' or $plan-cos = 'VMU20' or $plan-cos = 'VMU41' or $plan-cos = 'COS41'">true</xsl:when>
		<xsl:when test="$aw-boltons='true'">
			<xsl:choose>
				<xsl:when test="$has_current_aw='true' or $has_pending_aw='true'">false</xsl:when>
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>false</xsl:otherwise>
	</xsl:choose>
  </xsl:variable>
   
	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
			<title>Virgin Mobile USA</title>
            <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
            <xsl:text disable-output-escaping="yes">
            <![CDATA[<script src="${adobe_dtm}"></script>]]>
            </xsl:text>
			 <meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
			<link href="${base_url_secure}/_img/favicon.ico" rel="shortcut icon"/>
			<link rel="stylesheet" type="text/css" href="${base_url_secure}/_css/base-secure.css" />
			<link rel="stylesheet" type="text/css" href="${base_url_secure}/_js/jquery/colorbox/myaccount_dark.css" />
			<link href="${base_url_secure}/_js/jquery/colorbox/plainwhite.css" title="plainwhite" type="text/css" rel="alternate stylesheet" />
			<link rel="stylesheet" type="text/css" href="${base_url_secure}/_js/jquery/cluetip/jquery.cluetip.css" />
			<link rel="stylesheet" type="text/css" href="${base_url_secure}/_css/2013/bootstrap.css" />
			<link rel="stylesheet" type="text/css" href="${base_url_secure}/_css/2013/vmu.css" />
			<link rel="stylesheet" type="text/css" href="${base_url_secure}/_css/2013/VMU-myaccount_home.css" />
			<link rel="stylesheet" type="text/css" href="${base_url_secure}/_css/2013/VMU-myaccount_displays.css" />

            
          	<xsl:text disable-output-escaping="yes">
				&lt;script type="text/javascript" src="${base_url_secure}/_js/jquery/jquery-1.11.0.min.js"&gt;&lt;/script&gt;
				&lt;script type="text/javascript" src="${base_url_secure}/_js/jquery/jquery-migrate-1.2.1.min.js"&gt;&lt;/script&gt;
				&lt;script type="text/javascript" src="${base_url_secure}/_js/jquery/jquery.jcarousel.pack.js"&gt;&lt;/script&gt;
				&lt;script type="text/javascript" src="${base_url_secure}/_js/jquery/jquery.cookie.js"&gt;&lt;/script&gt;
				&lt;script type="text/javascript" src="${base_url_secure}/_js/jquery/jquery.equalheights.js"&gt;&lt;/script&gt;
				&lt;script type="text/javascript" src="${base_url_secure}/_js/jquery/jquery.pngfix.js"&gt;&lt;/script&gt;
				&lt;script type="text/javascript" src="${base_url_secure}/_js/jquery/jquery.url.packed.js"&gt;&lt;/script&gt;
				&lt;script type="text/javascript" src="${base_url_secure}/_js/jquery/colorbox/jquery.colorbox.js"&gt;&lt;/script&gt;
				&lt;script type="text/javascript" src="${base_url_secure}/_js/jquery/jquery.scrollTo-1.4.1-min.js"&gt;&lt;/script&gt;
                &lt;script type="text/javascript" src="${base_url_secure}/_js/jquery/cluetip/jquery.cluetip.js"&gt;&lt;/script&gt;
				&lt;script type="text/javascript" src="${base_url_secure}/_js/phones_data.js"&gt;&lt;/script&gt;
				&lt;script type="text/javascript" src="${base_url_secure}/_js/base-secure_vds.js"&gt;&lt;/script&gt;
				&lt;script type="text/javascript" src="${base_url_secure}/_js/vmst.js"&gt;&lt;/script&gt;
				&lt;script type="text/javascript" src="${base_url_secure}/_js/tabnav.js"&gt;&lt;/script&gt;
				&lt;script type="text/javascript" src="${base_url_secure}/foresee/foresee-trigger-secure.js"&gt;&lt;/script&gt;
            	&lt;script type="text/javascript" src="${base_url_secure}/_js/bootstrap/bootstrap.min.js"&gt;&lt;/script&gt;

			</xsl:text>

			<script type="text/javascript">
				var firstName = '<xsl:value-of select="normalize-space(/vmu-page/account-info/customer-firstname)" />';
				var lastName = '<xsl:value-of select="normalize-space(/vmu-page/account-info/customer-lastname)" />';
				nameString = Base64.encode(firstName + ' ' + lastName.substring(0,1) + '.');
				isMyAccountMain = true;
				var url_string= location.href;
				
				var site_domain = location.href;
				var cookie_domain = "";
				
				if(site_domain.indexOf("sprint") != -1){
					cookie_domain = '.sprint.com';
				}
				else{
					cookie_domain = '.virginmobileusa.com';
				}

				// Ratings and Reviews Redirect Check
				var reviewURL = $j.cookie('reviewURL');
				if (reviewURL) {
					// set the cstid cookie
					var cstid = Base64.encode('<xsl:value-of select="normalize-space(/vmu-page/login-session/phone-number)"/>');
					$j.cookie('cstid', cstid, {path: '/', domain: cookie_domain});
					
					// remove reviewURL cookie
					$j.cookie('reviewURL', null, {path: '/', domain: cookie_domain});					
					
					// push to page 
					window.location.href = reviewURL;
				}
				
				// PayPal Transaction Cookie
				
				if ($j.cookie('ppt')) {
						$j.cookie('ppt', null, {path: '/', domain: cookie_domain});	
				}
				
				if ($j.cookie('pptsp')) {
						$j.cookie('pptsp', null, {path: '/', domain: '.sprint.com'});	
				}
				
				if ($j.cookie('needs_to_cure')) {
						$j.cookie('needs_to_cure', null, {path: '/', domain: cookie_domain});	
				}
				
				var tracking_code_status="not done";
				var hotspot_message_for_tracking = "";
				var trackingMsgMonthly = "";
				var trackingMsgOneTime ="";
				var monthlyMOUString = "";
				var monthlyFeatureString = "";

				//initialize these as false
				$j.cookie('hasmonthlyhotspot', 'false', {path: '/', domain: cookie_domain});
				$j.cookie('hashibolton', 'false', {path: '/', domain: cookie_domain});
				$j.cookie('hasiphone', 'false', {path: '/', domain: cookie_domain});
				$j.cookie('useddiscount', 'false', {path: '/', domain: cookie_domain});
				$j.cookie('hasmonthlyinternationals', 'false', {path: '/', domain: cookie_domain});
																

				$j(document).ready(function() {
											
					$j('a.load-local').cluetip({local:true, activation: 'hover',cluetipClass: 'rounded',cursor: 'pointer',width: 'auto', height:'auto',showTitle: false,arrows:false,sticky:false,dropShadow:false,positionBy:'bottomTop'});
					$j('a.discount-eligible').cluetip({local:true, activation: 'hover',cluetipClass: 'rounded',cursor: 'pointer',width: '500px', height:'auto',showTitle: false,arrows:false,sticky:false,dropShadow:false,positionBy:'bottomTop'});
					$j('a.discount-applied').cluetip({local:true, activation: 'hover',cluetipClass: 'rounded',cursor: 'pointer',width: '500px', height:'auto',showTitle: false,arrows:false,sticky:false,dropShadow:false,positionBy:'bottomTop'});
					
					myaccount_links();
					initMyAccount();
					
					$j("#loading-div-background").hide();
					$j("#loading-div").hide();

					
					$j.cookie('phonenumber','<xsl:value-of select="normalize-space(/vmu-page/account-info/formatted-min)"/>', {path: '/', domain: cookie_domain});

					// set cookie for name in nav
					$j.cookie('u_log_disp', nameString, {path: '/', domain: cookie_domain});

					
				});
			</script>
			<xsl:apply-templates mode="loginCookie"/>
            <xsl:text disable-output-escaping="yes">
            <![CDATA[
                <script type="text/javascript" src="//s.btstatic.com/tag.js">
                { site: "qgTHzbz", mode: "sync" }
                </script>
             ]]>
            </xsl:text>
            </head>
            <body id="page_my_account_home">
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="$plan-type = 'virginmobile'">
						<xsl:text>log log_pre page_my_account page_beyondtalk</xsl:text></xsl:when>
					<xsl:otherwise>
						<xsl:text>log log_pre page_my_account page_</xsl:text><xsl:value-of select="$plan-type" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<div id="loading-div-background"><xsl:comment>.</xsl:comment></div>
			<div id="loading-div" class="ui-corner-all" >
				<img src="${base_url_secure}/_img/ajax-loader.gif" alt="Loading.."/>
				<h2 style="color:gray;font-weight:normal;font-size:14px;">Please wait....</h2>
			</div>
			
			<xsl:call-template name="time_warning"/>
			
			<xsl:call-template name="mrc-discount-rollovers"/>
							
			<div id="popupContact" style="width:280px;display:none;background-color:#fff;padding:10px;-webkit-box-shadow: 2px 2px 5px 2px #999;box-shadow: 2px 2px 5px 2px #999;border-radius:3px;">
				<p style="margin-bottom:0px">Pay Now lets you make your payment for next month's service up to one month in advance. When you Pay Now, we'll apply your payment to your next monthly charge. That way, you won't have to worry about paying at the end of your month and you won't risk interrupting your service. </p>
			</div>
		
			<div id="pageWrapper">
				<div id="container">
					<div id="header">
						<xsl:apply-templates mode="header"/>
						<xsl:text disable-output-escaping="yes">
			    		<![CDATA[
							<!--
							Start of DoubleClick Floodlight Tag: Please do not remove
							Activity name of this tag: Virgin - My Account
							URL of the webpage where the tag is expected to be placed: http://www.virginmobileusa.com
							This tag must be placed between the <body> and </body> tags, as close as possible to the opening tag.
							Creation Date: 07/02/2014
							-->
							<script type="text/javascript">
								var axel = Math.random() + "";
								var a = axel * 10000000000000;
								document.write('<iframe src="https://3717615.fls.doubleclick.net/activityi;src=3717615;type=virgi536;cat=virgi585;ord=1;num=' + a + '?" width="1" height="1" frameborder="0" style="display:none"></iframe>');
							</script>
							<noscript>
								<iframe src="https://3717615.fls.doubleclick.net/activityi;src=3717615;type=virgi536;cat=virgi585;ord=1;num=1?" width="1" height="1" frameborder="0" style="display:none"></iframe>
							</noscript>
							<!-- End of DoubleClick Floodlight Tag: Please do not remove -->
						]]>
			    		</xsl:text>
					</div>
					<div id="mainContent" class="container">
						<div id="headerimage" class="vcard">
							<div class="welcome">
								<h1>WELCOME BACK, 
									<span class="fn">
									<xsl:comment>mp_trans_disable_start</xsl:comment>
									<xsl:value-of select="/vmu-page/account-info/customer-firstname" /><xsl:text> </xsl:text><xsl:value-of select="/vmu-page/account-info/customer-lastname" />
									<xsl:comment>mp_trans_disable_end</xsl:comment>
									</span>
								</h1>
							</div>
							<div class="plan_details">
								<xsl:if test="contains($plan-cos,'COS315')">
									<xsl:attribute name="style">width:150px</xsl:attribute>
								</xsl:if>
								<xsl:if test="contains($plan-cos,'COS20')">
									<xsl:attribute name="style">left:615px</xsl:attribute>
								</xsl:if>
								<xsl:if test="$plan-type = 'assurance'">
									<h2>Assurance Wireless</h2>
								</xsl:if>
								
								<xsl:call-template name="phone-name-display">
									<xsl:with-param name="sku-string" select="$phone-model-string"/>
									<xsl:with-param name="display-context">myaccount</xsl:with-param>
								</xsl:call-template>
								
								<span id="your_phone_name" style="display:none;"><xsl:value-of select="$phone-model-string"/></span>
								
								<p class="tel"><xsl:value-of select="/vmu-page/account-info/formatted-min"/></p>
								
								<xsl:call-template name="plan-cos-full-plan-description">
									<xsl:with-param name="cos" select="$plan-cos"/>
									<xsl:with-param name="context">myaccount</xsl:with-param>
								</xsl:call-template>
														
							</div>
							<div class="phone">
								
								<xsl:call-template name="phone-image-display">
									<xsl:with-param name="sku-string" select="$phone-model-string"/>
									<xsl:with-param name="display-context">myaccount</xsl:with-param>
								</xsl:call-template>
							</div>

							<ul class="tabnav">
								<li><a id="tab1" class="tab1" rel="ao">Account Overview</a></li>
								<li><a id="tab2" class="tab2" rel="pa">Phone, Apps &amp; More</a></li>
								<li><a id="tab3" class="tab3" rel="sp">Settings &amp; Preferences</a></li>
								<li><a id="tab4" class="tab4" rel="pl">Programs &amp; The Latest</a></li>
							</ul>
						</div>
						<div id="prod_info">
							<div class="tabContent clearfix hidingblocks" id="ao">
							
								<xsl:call-template name="display-balance-info" />
								
								<div class="row">
									<div class="col-md-12">
										<div id="account_activity_container">
                                            <div class="row">
                                                <div class="column_wide col-md-9">

                                                    <div id="account_activity">
                                                        <div class="row">
                                                            <div class="col-md-8">
                                                                <h2 class="hdl_section_title" id="hdl_accountactivity">Account Activity</h2>
                                                            </div>
                                                            <div class="col-md-4 text-right">
                                                                <a href="/myaccount/accountHistory.do" class="more my_account_overlay">// View All Account History</a>
                                                            </div>
                                                        </div>

                                                        <!-- NEEDS TO BE FIXED -->
                                                        <xsl:if test="/vmu-page/messages/message/key='error.pendingMigration.advancePaymentExist'">
                                                            <div id="advanced_payment_error" class="alert alert-icon" style="margin-bottom:10px">
                                                                <h4 style="font-weight:bold">There is an Advance Payment on the account.</h4>
                                                                <p>Please refund the advance payment and then cancel the pending migration order.</p>
                                                            </div>
                                                        </xsl:if>
                                                        <!-- ENDS NEEDS TO BE FIXED -->

                                                        <xsl:if test="contains($has-pending-internationals,'true') or contains($has_pending_hotspot,'true') or $has_pending_aw='true' or $has_pending_migration='true' or $has_pending_hi='true' or contains($has-pending-additional-features,'true')">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <!-- PENDING CONTAINER -->
                                                                <div id="pending-migration-notice">
                                                                    <!-- up arrow -->
                                                                    <a data-toggle="collapse" data-target="#full_details" id="toggle_expand" class="toggle_up" onclick="$j('#toggle_expand').toggle();$j('#toggle_collapse').toggle();$j('#message-expanded').toggle();$j('#message-collapsed').toggle();return false;">Details</a>
                                                                    <!-- end up arrow -->

                                                                    <!-- down arrow -->
                                                                    <a data-toggle="collapse" data-target="#full_details" id="toggle_collapse" class="toggle_down" onclick="$j('#toggle_expand').toggle();$j('#toggle_collapse').toggle();$j('#message-expanded').toggle();$j('#message-collapsed').toggle();return false;">Hide Full Details</a>
                                                                    <!-- end down arrow -->

                                                                    <!-- message -->
                                                                    <h5 id="message-collapsed">Pending changes to your plan will begin on <xsl:value-of select="/vmu-page/login-session/ctd-plus-1"/>.&#160;<a data-toggle="collapse" data-target="#full_details" id="link_for_details"  onclick="$j('#toggle_expand').toggle();$j('#toggle_collapse').toggle();$j('#message-expanded').toggle();$j('#message-collapsed').toggle();return false;">Details</a></h5>

                                                                    <h5 id="message-expanded" style="display:none">Pending changes to your plan will begin on <xsl:value-of select="/vmu-page/login-session/ctd-plus-1"/>.&#160;<a data-toggle="collapse" data-target="#full_details" id="link_for_details" onclick="$j('#toggle_expand').toggle();$j('#toggle_collapse').toggle();$j('#message-expanded').toggle();$j('#message-collapsed').toggle();return false;">Hide Details</a></h5>
                                                                    <!-- end message -->

                                                                    <!-- details -->
                                                                    <div id="full_details" class="collapse">

                                                                        <!-- PENDING PENDING INTERNATIONAL STUFF-->
                                                                        <xsl:if test="contains($has-pending-internationals,'true')">

                                                                            <ul class="list-unstyled">
                                                                                <xsl:call-template name="international-information">
                                                                                    <xsl:with-param name="context">show-pending</xsl:with-param>
                                                                                </xsl:call-template>

                                                                                <li>
                                                                                    Your Next Payment is: <strong>
                                                                                        <xsl:choose>
                                                                                            <xsl:when test="/vmu-page/account-info/black-berry/@flag ='true'">
                                                                                                $<xsl:value-of select="format-number($total_amount_due_blackberry,'##.00')"/>
                                                                                            </xsl:when>
                                                                                            <xsl:otherwise>
                                                                                                <xsl:choose>
                                                                                                    <xsl:when test="string-length(/vmu-page/account-info/next-payment-due/total) &gt; 1"><xsl:value-of select="/vmu-page/account-info/next-payment-due/total"/></xsl:when>
                                                                                                    <xsl:otherwise>
                                                                                                        <xsl:value-of select="/vmu-page/account-info/plan-info/total"/>
                                                                                                    </xsl:otherwise>
                                                                                                </xsl:choose>
                                                                                            </xsl:otherwise>
                                                                                        </xsl:choose>
                                                                                        due on <xsl:value-of select="/vmu-page/account-info/next-payment-due/topup-by-date"/></strong>
                                                                                </li>
                                                                            </ul>
                                                                            <p><a id="btn_plan-migration-cancel" href="/myaccount/manageInternationalOffer.do" class="my_account_overlay">Manage International Offers</a></p>
                                                                        </xsl:if>
                                                                        <!-- END PENDING INTERNATIONAL STUFF -->

                                                                        <!-- PENDING PENDING ADDITIONAL FEATURES STUFF-->
                                                                        <xsl:if test="contains($has-pending-additional-features,'true')">

                                                                            <ul class="list-unstyled">
                                                                                <xsl:call-template name="additional-features-information">
                                                                                    <xsl:with-param name="context">show-pending</xsl:with-param>
                                                                                </xsl:call-template>

                                                                                <li>
                                                                                    Your Next Payment is: <strong>
                                                                                        <xsl:choose>
                                                                                            <xsl:when test="/vmu-page/account-info/black-berry/@flag ='true'">
                                                                                                $<xsl:value-of select="format-number($total_amount_due_blackberry,'##.00')"/>
                                                                                            </xsl:when>
                                                                                            <xsl:otherwise>
                                                                                                <xsl:choose>
                                                                                                    <xsl:when test="string-length(/vmu-page/account-info/next-payment-due/total) &gt; 1"><xsl:value-of select="/vmu-page/account-info/next-payment-due/total"/></xsl:when>
                                                                                                    <xsl:otherwise>
                                                                                                        <xsl:value-of select="/vmu-page/account-info/plan-info/total"/>
                                                                                                    </xsl:otherwise>
                                                                                                </xsl:choose>
                                                                                            </xsl:otherwise>
                                                                                        </xsl:choose>
                                                                                        due on <xsl:value-of select="/vmu-page/account-info/next-payment-due/topup-by-date"/></strong>
                                                                                </li>
                                                                            </ul>
                                                                        </xsl:if>
                                                                        <!-- END PENDING ADDITIONAL FEATURES STUFF -->


                                                                        <!-- PENDING HOTSPOT STUFF-->
                                                                        <xsl:if test="contains($has_pending_hotspot,'true')">
                                                                            <script>
                                                                                ///set a cookie to record that the user has a pending hotspot for advance payments
                                                                                $j.cookie('hasmonthlyhotspot', 'false', {path: '/', domain: cookie_domain});
                                                                            </script>
                                                                            <ul class="list-unstyled">
                                                                            <xsl:choose>
                                                                                <xsl:when test="/vmu-page/login-session/hotspot">

                                                                                        <xsl:call-template name="hotspot-information">
                                                                                            <xsl:with-param name="context">show-pending</xsl:with-param>
                                                                                        </xsl:call-template>

                                                                                </xsl:when>
                                                                                <xsl:otherwise>

                                                                                        <li>
                                                                                         <xsl:choose>
                                                                                            <!-- 04/16/2013: per IBM for 8419, i think i'm supposed to use expairation-date here.-->
                                                                                            <!-- user is removing the hotspot -->
                                                                                            <xsl:when test="normalize-space(/vmu-page/account-info/hotspot/active/status)='Unsubscribe'">Your Mobile Hotspot service will be removed on: <strong style="text-transform:uppercase;font-weight:bold">&#160;<xsl:value-of select="/vmu-page/account-info/hotspot/active/expairation-date"/><!--<xsl:value-of select="/vmu-page/login-session/ctd-plus-1"/>--></strong></xsl:when>
                                                                                            <!-- end user is removing the hotspot -->

                                                                                            <!-- user is adding the hotspot -->
                                                                                            <xsl:when test="normalize-space(/vmu-page/account-info/hotspot/active/status)='Pending'">Your Mobile Hotspot service will begin on: <strong style="text-transform:uppercase;font-weight:bold">&#160;<xsl:value-of select="/vmu-page/login-session/ctd-plus-1"/></strong></xsl:when>
                                                                                            <!-- end user is adding the hotspot -->

                                                                                            <!-- hotspot is a one-timer and will expire at next MRC -->
                                                                                            <xsl:otherwise>Your Mobile Hotspot service will expire on: <strong style="text-transform:uppercase;font-weight:bold">&#160;<xsl:value-of select="/vmu-page/account-info/hotspot/active/expairation-date"/><!--<xsl:value-of select="/vmu-page/login-session/ctd-plus-1"/>--></strong></xsl:otherwise>
                                                                                            <!-- end hotspot is a one-timer and will expire at next MRC -->
                                                                                          </xsl:choose>
                                                                                          </li>
                                                                                        </xsl:otherwise>
                                                                                    </xsl:choose>

                                                                                    <li>
                                                                                      Your Next Payment is: <strong>
                                                                                      <xsl:choose>
                                                                                        <xsl:when test="/vmu-page/account-info/black-berry/@flag ='true'">
                                                                                            $<xsl:value-of select="format-number($total_amount_due_blackberry,'##.00')"/>
                                                                                        </xsl:when>
                                                                                        <xsl:otherwise>
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="string-length(/vmu-page/account-info/next-payment-due/total) &gt; 1"><xsl:value-of select="/vmu-page/account-info/next-payment-due/total"/></xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    <xsl:value-of select="/vmu-page/account-info/plan-info/total"/>
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                        </xsl:otherwise>
                                                                                      </xsl:choose>
                                                                                      due on <xsl:value-of select="/vmu-page/account-info/next-payment-due/topup-by-date"/></strong>
                                                                                      </li>
                                                                                </ul>
                                                                                <p><a id="btn_plan-migration-cancel" href="/myaccount/prepareHotspotService.do" class="my_account_overlay">Change Mobile Hotspot Settings</a></p>
                                                                        </xsl:if>
                                                                        <!-- END PENDING HOTSPOT STUFF -->

                                                                       <!-- PENDING BOLTON STUFF FOR AW-->
                                                                        <xsl:if test="$has_pending_aw='true'">

                                                                            <ul class="list-unstyled">
                                                                                <xsl:if test="$current-aw-bolton-status = 'U'">
                                                                                    <li>
                                                                                        <h2>You will be unsubscribed from this offer:</h2>
                                                                                        <xsl:call-template name="aw-bolton-descriptions">
                                                                                            <xsl:with-param name="bolton-name" select="$current-aw-bolton"/>
                                                                                        </xsl:call-template>
                                                                                        <br/><br/>
                                                                                    </li>
                                                                                </xsl:if>
                                                                                <xsl:if test="$pending-aw-bolton-status = 'P'">
                                                                                    <li>
                                                                                        <h2>You will be subscribed to this offer:</h2><br/>
                                                                                        <xsl:call-template name="aw-bolton-descriptions">
                                                                                            <xsl:with-param name="bolton-name" select="$pending-aw-bolton"/>
                                                                                        </xsl:call-template>
                                                                                    </li>
                                                                                </xsl:if>
                                                                            </ul>
                                                                            <p><a id="btn_plan-migration-cancel" href="/myaccount/cancelAWPendingBolton.do" class="my_account_overlay">Cancel My Plan Change</a></p>
                                                                        </xsl:if>
                                                                        <!-- END PENDING BOLTON STUFF FOR AW -->
                                                                        <!-- PENDING MIGRATION STUFF -->
                                                                        <xsl:if test="$has_pending_migration='true'">
                                                                            <xsl:variable name="migrating-to-this-plan" select="normalize-space(/vmu-page/account-info/pending-plan-migration/plan-info/@cos)"/>

                                                                            <h2>New Plan</h2>
                                                                            <hr/>
                                                                            <ul class="list-unstyled">
                                                                                <li>
                                                                                    <strong>
                                                                                        <xsl:call-template name="choose-plan-name-template">
                                                                                            <xsl:with-param name="cos" select="$migrating-to-this-plan"/>
                                                                                        </xsl:call-template>
                                                                                    </strong> 
                                                                                </li>
                                                                                <!-- Might have to change this blackberry bolt on stuff to be dynamic per the 11.3 xml spec -->

                                                                                <xsl:if test="/vmu-page/account-info/pending-plan-migration/plan-info/msg-pack-option = 'RIM.SERVICE.PROSUMER_B' or /vmu-page/account-info/pending-plan-migration/plan-info/msg-pack-option = 'VMU10BLK'">
                                                                                    <li>BlackBerry Ad-On Service: 
                                                                                        <xsl:choose>
                                                                                            <xsl:when test="/vmu-page/account-info/black-berry/blackberry-cost='0.00'">
                                                                                                <strong>0/month</strong>
                                                                                            </xsl:when>
                                                                                            <xsl:otherwise>
                                                                                                <strong>$10/month</strong>
                                                                                            </xsl:otherwise>
                                                                                         </xsl:choose>
                                                                                    </li>
                                                                                </xsl:if>
                                                                            </ul>
                                                                            <!-- This template has its own UL, so I end the UL started above and start a new one -->
                                                                                <xsl:call-template name="choose-plan-whats-inlcuded">
                                                                                    <xsl:with-param name="cos" select="$migrating-to-this-plan"/>
                                                                                </xsl:call-template>
                                                                            <!-- END This template has its own UL, so I end the UL started above and start a new one -->
                                                                            <ul class="list-unstyled">
                                                                                <!-- 12.2 NEW LINE FOR HOTSPOT only show the hotspot cost if it's recurring -->
                                                                                <xsl:choose>
                                                                                    <xsl:when test="/vmu-page/login-session/hotspot">
                                                                                        <xsl:call-template name="hotspot-information">
                                                                                            <xsl:with-param name="context">show-line-in-pending-plan-migration</xsl:with-param>
                                                                                        </xsl:call-template>
                                                                                    </xsl:when>
                                                                                    <xsl:when test="/vmu-page/account-info/hotspot/active/hotspot-type='Recurring'">
                                                                                        <xsl:choose>
                                                                                                <xsl:when test="/vmu-page/account-info/hotspot/active/status='Unsubscribe'">

                                                                                                <script>
                                                                                                    ///set a cookie to record that the user has a pending hotspot for advance payments
                                                                                                    $j.cookie('hasmonthlyhotspot', 'false', {path: '/', domain: cookie_domain});
                                                                                                </script>
                                                                                            </xsl:when>
                                                                                            <xsl:otherwise>
                                                                                                <script>
                                                                                                ///set a cookie to record that the user has a pending hotspot for advance payments
                                                                                                $j.cookie('hasmonthlyhotspot', 'true', {path: '/', domain: cookie_domain});
                                                                                            </script>
                                                                                            </xsl:otherwise>
                                                                                        </xsl:choose>
                                                                                        <li>Mobile Hotspot: <strong>$<xsl:value-of select="/vmu-page/account-info/hotspot/active/monthly-cost"/>/month</strong>
                                                                                        </li>
                                                                                    </xsl:when>
                                                                                </xsl:choose>
                                                                                <!-- END NEW LINE FOR HOTSPOT -->
                                                                                <!-- NEW LINE FOR INSURANCE -->
                                                                                <xsl:choose>
                                                                                    <xsl:when test="/vmu-page/account-info/pending-plan-migration/plan-info/insurance-product-option='VPHINSU' or /vmu-page/account-info/pending-plan-migration/plan-info/insurance-product-option='PHNINS'">
                                                                                        <script>
                                                                                            ///set a cookie to record that the user has the $5 bolton
                                                                                            $j.cookie('hashibolton', 'true', {path: '/', domain: cookie_domain});
                                                                                        </script>
                                                                                        <li>Phone Insurance: <strong>$<xsl:value-of select="/vmu-page/account-info/pending-plan-migration/plan-info/insurance-product-option/@cost"/></strong>
                                                                                        </li>
                                                                                    </xsl:when>
                                                                                    <xsl:otherwise>
                                                                                        <script>
                                                                                            ///set a cookie to record that the user has the $5 bolton
                                                                                            $j.cookie('hashibolton', 'false', {path: '/', domain: cookie_domain});
                                                                                        </script>
                                                                                    </xsl:otherwise>
                                                                                </xsl:choose>
                                                                                <!-- END NEW LINE FOR INSURANCE -->
                                                                                <!--INTERNATIONAL OFFERS -->
                                                                                    <xsl:call-template name="international-information">
                                                                                        <xsl:with-param name="context">show-line-in-pending-plan-migration</xsl:with-param>
                                                                                    </xsl:call-template>
                                                                                <!-- END INTERNATIONAL OFFERS -->
                                                                                <!-- ADDITIONAL FEATURES -->
                                                                                <xsl:call-template name="additional-features-information">
                                                                                    <xsl:with-param name="context">show-line-in-pending-plan-migration</xsl:with-param>
                                                                                </xsl:call-template>
                                                                                <!-- END ADDITIONAL FEATURES -->
                                                                                <li>Total Monthly Charges:
                                                                                    <xsl:choose>
                                                                                    <!-- Might have to make this dynamic per the 11.3 xml spec -->
                                                                                        <xsl:when test="/vmu-page/account-info/black-berry/@flag ='true'">
                                                                                            <strong>$<xsl:value-of select="format-number($total_monthly_charge_blackberry,'##.00')"/></strong>
                                                                                        </xsl:when>
                                                                                        <xsl:otherwise>
                                                                                            <strong><xsl:value-of select="/vmu-page/account-info/pending-plan-migration/next-payment"/></strong>
                                                                                        </xsl:otherwise>
                                                                                    </xsl:choose>
                                                                                </li>
                                                                                <li>
                                                                                    <xsl:choose>
                                                                                        <xsl:when test="$migrating-to-this-plan = 'COS807' or contains($migrating-to-this-plan,'809')">Your Next Month Starts: <strong><!-- 04/23/2013, changing this to <xsl:value-of for 8419 per IBM /vmu-page/account-info/next-payment-due/topup-by-date <xsl:value-of select="/vmu-page/account-info/pending-plan-migration/start-date"/>-->
                                                                                            <xsl:value-of select="/vmu-page/account-info/next-payment-due/topup-by-date"/></strong>
                                                                                        </xsl:when>
                                                                                        <xsl:otherwise>
                                                                                            Your Next Payment is: <strong>
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="/vmu-page/account-info/black-berry/@flag ='true'">
                                                                                                    $<xsl:value-of select="format-number($total_amount_due_blackberry,'##.00')"/>&#160;
                                                                                                </xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    <xsl:value-of select="/vmu-page/account-info/pending-plan-migration/next-payment"/>&#160;
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                            due on <xsl:value-of select="/vmu-page/account-info/next-payment-due/topup-by-date"/></strong>
                                                                                        </xsl:otherwise>
                                                                                    </xsl:choose>
                                                                                </li>
                                                                            </ul>
                                                                            <p>
                                                                                <a id="btn_plan-migration-cancel" href="/myaccount/cancelPendingMigration.do">
                                                                                <!--<xsl:if test="$migrating-to-this-plan = 'COS807'">
                                                                                <xsl:attribute name="class">my_account_overlay</xsl:attribute>
                                                                                </xsl:if> -->
                                                                                Cancel My Plan Change</a>
                                                                            </p>
                                                                        </xsl:if>
                                                                        <!-- END PENDING MIGRATION STUFF -->
                                                                        <!-- PENDING INSURANCE STUFF -->
                                                                        <xsl:if test="$has_pending_hi='true'">
                                                                            <h2 style="text-transform:none;color:#000;font-weight:bold">
                                                                                <xsl:choose>
                                                                                    <xsl:when test="normalize-space(/vmu-page/account-info/insurance/active/status) = 'Pending'">
                                                                                    <h2>You have added phone insurance to your account</h2>
                                                                                    </xsl:when>
                                                                                    <xsl:otherwise>
                                                                                        <h2>You have removed phone insurance from your account</h2>
                                                                                    </xsl:otherwise>

                                                                                </xsl:choose>
                                                                            </h2>
                                                                            <hr/>
                                                                            <ul class="list-unstyled">
                                                                                <!-- NEW LINE FOR INSURANCE -->
                                                                                <xsl:if test="$insurance-type='hi-bolton' or $insurance-name='VPHINSU' or contains($insurance-name,'$5 Phone Insurance') or $insurance-name='PHNINS'">
                                                                                <script>
                                                                                    ///set a cookie to record that the user has a $5 phone insurance (for advance payments)
                                                                                    $j.cookie('hashibolton', 'true', {path: '/', domain: cookie_domain});
                                                                                </script>
                                                                                <li>Phone Insurance: <strong>$<xsl:value-of select="$insurance-cost"/>/month</strong>
                                                                                </li>
                                                                                </xsl:if>
                                                                                <!-- END NEW LINE FOR INSURANCE -->

                                                                                <li>New Total Monthly Charges: <strong><xsl:value-of select="/vmu-page/account-info/next-payment-due/total"/></strong>
                                                                                </li>
                                                                                <li>Your Next Payment is due on: <strong>
                                                                                <xsl:value-of select="/vmu-page/account-info/next-payment-due/topup-by-date"/></strong></li>
                                                                            </ul>
                                                                        </xsl:if>
                                                                        <!-- END PENDING INSURANCE STUFF -->
                                                                    </div>
                                                                    <!-- end details -->
                                                                </div>
                                                            <!-- END PENDING MIGRATION CONTAINER -->
                                                            </div>
                                                        </div>

                                                        </xsl:if>

                                                        <!-- ACCOUNT ACTIVITY -->

                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-12 well-midgray-gradient" id="account_activity_cols">
                                                                    <div class="row">
                                                                        <!-- MINUTES USED/LEFT -->
                                                                        <div id="account_minutes" class="col-md-3">
                                                                            <xsl:choose>
                                                                                <xsl:when test="$show-minute-rate = 'true' and $show-minute-packs='false'">
                                                                                    <h3>Per Minute Rate</h3>
                                                                                    <p id="remaining_minutes"><strong>
                                                                                        <xsl:value-of select="$per-minute-rate"/></strong>
                                                                                    </p>
                                                                                </xsl:when>
                                                                                <xsl:when test="$show-minute-packs='true'">
                                                                                    <h3>Minute Pack<br/>Minutes Remaining</h3>
                                                                                    <p id="remaining_minutes"><strong><xsl:value-of select="$total-mins-left"/></strong>/<xsl:value-of select="$total-mins"/></p>
                                                                                </xsl:when>
                                                                                <xsl:when test="$unlimited-minutes-plan='true'">
                                                                                    <h3>Anytime Minutes</h3>
                                                                                    <p id="remaining_minutes"><strong style="font-size:18px">Unlimited</strong></p>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <h3>Anytime Minutes Used</h3>
                                                                                    <p id="remaining_minutes">
                                                                                        <strong><xsl:value-of select="$total-mins-used"/></strong>
                                                                                        <xsl:if test="$show-mins-left='true'">
                                                                                        <xsl:text>&#160;/&#160;</xsl:text>
                                                                                            <xsl:value-of select="$total-mins"/>
                                                                                        </xsl:if>
                                                                                    </p>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                            <!-- MINUTE PACK PURCHASE LINK FOR COS199 -->
                                                                                                                                                                                                                         <xsl:if test="$show-minute-pack-purchase='true'">
                                                                                <a class="my_account_overlay btn btn-default btn-sm" href="/myaccount/prepareMinutePack.do" >Purchase Minute Pack</a>
                                                                              </xsl:if>
                                                                              <!-- END MINUTE PACK PURCHASE LINK FOR COS199 -->
                                                                        </div>
                                                                        <!-- END MINUTES USED/LEFT -->
                                                                        <!-- PLAN DETAILS -->
                                                                        <div id="account_plan" class="col-md-6">
                                                                            <h3>
                                                                                <xsl:text>Your </xsl:text>
                                                                                <xsl:choose>
                                                                                    <xsl:when test="$plan-type = 'paylo'">payLo</xsl:when>
                                                                                    <xsl:when test="$plan-type = 'assurance'">Assurance Wireless</xsl:when>
                                                                                    <xsl:when test="$plan-type='beyondtalk'">Beyond Talk</xsl:when>
                                                                                    <xsl:otherwise>Virgin Mobile</xsl:otherwise>
                                                                                </xsl:choose>
                                                                                <xsl:text> Plan</xsl:text>
                                                                            </h3>
                                                                            <!-- YOUR PLAN TABLE -->
                                                                            <table cellspacing="0" cellpadding="0" border="0">
                                                                            <xsl:choose>
                                                                                <!-- BY THE MINUTE PLANS -->
                                                                                <xsl:when test="$show-minute-rate='true'">
                                                                                    <tr>
                                                                                        <th>Basic Phone Rate</th>
                                                                                        <td>
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="$plan-cos = 'COS20' or $plan-cos = 'VMU20'">
                                                                                                25&#162;/min for first 10 mins per day;
                                                                                                10&#162;/min thereafter
                                                                                                </xsl:when>
                                                                                                <xsl:when test="$show-minute-packs='true'">Pay As You Go</xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    <xsl:value-of select="$per-minute-rate"/>/min
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <!-- BONUS MINUTES DISPLAY -->
                                                                                    <xsl:call-template name="bonus_minutes_display"/>
                                                                                    <!-- END BONUS MINUTES DISPLAY -->
                                                                                    <xsl:choose>
                                                                                        <xsl:when test="$plan-type='assurance'">
                                                                                            <!-- in case the AW customer buys a message pack -->
                                                                                            <xsl:call-template name="aw-messaging-pack-display"/>
                                                                                            <!-- END in case the AW customer buys a message pack -->

                                                                                            <!-- in case the AW customer buys a data pack -->

                                                                                            <xsl:call-template name="aw-data-pack-display"/>
                                                                                            <!-- END in case the AW customer buys a data pack -->

                                                                                            <xsl:if test="boolean(/vmu-page/account-info/lifelineExpiryDate)" >
                                                                                            <tr>
                                                                                                <th>Service expires on</th>
                                                                                                <td><xsl:value-of select="/vmu-page/account-info/lifelineExpiryDate" /></td>
                                                                                            </tr>
                                                                                            </xsl:if>
                                                                                        </xsl:when>
                                                                                        <xsl:otherwise>
                                                                                            <tr>
                                                                                                <th>Messages</th>
                                                                                                <td>
                                                                                                    <xsl:choose>
                                                                                                        <xsl:when test="$can-have-packs='true'">
                                                                                                            <xsl:call-template name="account-activity-messages">
                                                                                                                <xsl:with-param name="plan-cos" select="$plan-cos" />
                                                                                                            </xsl:call-template>
                                                                                                        </xsl:when>
                                                                                                        <xsl:otherwise>
                                                                                                            <xsl:value-of select="$total-plan-messages"/>
                                                                                                        </xsl:otherwise>
                                                                                                    </xsl:choose>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <th>Data</th>
                                                                                                <td>
                                                                                                    <xsl:choose>
                                                                                                        <xsl:when test="$can-have-packs='true'">
                                                                                                            <xsl:call-template name="account-activity-data">
                                                                                                                <xsl:with-param name="plan-cos" select="$plan-cos" />
                                                                                                            </xsl:call-template>
                                                                                                        </xsl:when>
                                                                                                        <xsl:otherwise>
                                                                                                            <xsl:value-of select="$total-plan-data"/>
                                                                                                        </xsl:otherwise>
                                                                                                    </xsl:choose>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </xsl:otherwise>
                                                                                    </xsl:choose>
                                                                                </xsl:when>
                                                                                <!-- END BY THE MINUTE PLANS -->
                                                                                <!-- COS807, COS805  and COS211: Assurance Wireless -->
                                                                                <xsl:when test="$aw-boltons='true'">


                                                                                            <xsl:choose>
                                                                                                <xsl:when test="$plan-cos = 'COS809'">
                                                                                                    <tr>
                                                                                                        <th>Free Minutes</th>
                                                                                                        <td>500</td> 
                                                                                                    </tr>
                                                                                                </xsl:when>
                                                                                                <xsl:when test="$plan-cos = 'COS815'">
                                                                                                    <tr>
                                                                                                        <th>Free Minutes</th>
                                                                                                        <td>500</td> 
                                                                                                    </tr>
                                                                                                </xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    <tr>
                                                                                                        <th>Free Minutes</th>
                                                                                                        <td>250</td>
                                                                                                    </tr>
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>

                                                                                    <!-- BONUS MINUTES DISPLAY -->
                                                                                    <xsl:call-template name="bonus_minutes_display"/>
                                                                                    <!-- END BONUS MINUTES DISPLAY -->

                                                                                    <!-- Don't show additional minutes if the user is on the unlimited bolton -->
                                                                                    <xsl:if test="$has_current_aw='true'">
                                                                                        <tr>
                                                                                            <th>Purchased Minutes</th>
                                                                                            <td>
                                                                                                <xsl:choose>
                                                                                                    <xsl:when test="$current-aw-bolton = 'ASW5BOLT'">250</xsl:when>
                                                                                                    <xsl:when test="$current-aw-bolton = 'ASW20BOLT'">750</xsl:when>
                                                                                                    <xsl:when test="$current-aw-bolton = 'AWMISM250'">250</xsl:when>
                                                                                                    <xsl:when test="$current-aw-bolton = 'AWMISM750'">750</xsl:when>
                                                                                                    <xsl:when test="$current-aw-bolton = 'AWMISDUNL' or $current-aw-bolton = 'ASW30BOLT'">Unlimited</xsl:when>
                                                                                                </xsl:choose>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </xsl:if>
                                                                                    <xsl:if test="contains($has-aw-promotional-offers,'true')">
                                                                                        <tr>
                                                                                            <th>Promotional Minutes</th>
                                                                                            <td>250
                                                                                            </td>
                                                                                        </tr>
                                                                                    </xsl:if>
                                                                                    <xsl:if test="$current-aw-bolton != 'AWMISDUNL' and $current-aw-bolton != 'ASW30BOLT'">
                                                                                        <tr>
                                                                                            <th>Additional Minutes</th>
                                                                                            <td>10&#162;/min</td>
                                                                                        </tr>
                                                                                    </xsl:if>

                                                                                    <!-- in case the AW customer buys a message pack -->

                                                                                    <xsl:call-template name="aw-messaging-pack-display"/>
                                                                                    <!-- END in case the AW customer buys a message pack -->

                                                                                    <!-- in case the AW customer buys a data pack -->
                                                                                    <xsl:call-template name="aw-data-pack-display"/>
                                                                                    <!-- END in case the AW customer buys a data pack -->

                                                                                    <xsl:if test="boolean(/vmu-page/account-info/lifelineExpiryDate)" >
                                                                                    <tr>
                                                                                        <th>Service expires on</th>
                                                                                        <td><xsl:value-of select="/vmu-page/account-info/lifelineExpiryDate" /></td>
                                                                                    </tr>
                                                                                    </xsl:if>
                                                                                </xsl:when>
                                                                                <!-- END COS807, COS805, COS211: Assurance Wireless -->
                                                                                <!-- MONTHLY PLANS, INCLUDING AW -->
                                                                                <xsl:otherwise>
                                                                                    <tr>
                                                                                        <th>Price</th>
                                                                                        <td>
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="contains($mrc-discount,'applied')">
                                                                                                    <xsl:call-template name="discount_display">
                                                                                                        <xsl:with-param name="plan_cos" select="$plan-cos"/>
                                                                                                        <xsl:with-param name="context">show-discount</xsl:with-param>
                                                                                                    </xsl:call-template>
                                                                                                </xsl:when>
                                                                                                <xsl:otherwise>

                                                                                                    <xsl:value-of select="$plan-cos-monthly-cost"/>/mo.
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                        </td>
                                                                                    </tr>

                                                                                    <xsl:choose>
                                                                                        <xsl:when test="$has-built-in-intl-mins='true'">
                                                                                            <tr>
                                                                                                <th>Included Domestic Anytime Minutes</th>
                                                                                                <td><xsl:value-of select="$total-mins"/></td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <th>Included International Minutes</th>
                                                                                                <td><xsl:value-of select="$built-in-intl-mins-used"/> of <xsl:value-of select="$built-in-intl-mins-total"/> used</td>
                                                                                            </tr>
                                                                                        </xsl:when>
                                                                                        <xsl:otherwise>
                                                                                            <tr>
                                                                                                <th>Anytime Minutes</th>
                                                                                                <td><xsl:value-of select="$total-mins"/></td>
                                                                                            </tr>
                                                                                        </xsl:otherwise>
                                                                                    </xsl:choose>

                                                                                    <!-- BONUS MINUTES DISPLAY -->
                                                                                    <xsl:call-template name="bonus_minutes_display"/>
                                                                                    <!-- END BONUS MINUTES DISPLAY -->
                                                                                    <xsl:choose>
                                                                                        <xsl:when test="$plan-type='assurance'">
                                                                                            <xsl:if test="$plan-cos = 'COS803' or $plan-cos = 'COS802'">
                                                                                                <tr>
                                                                                                    <th>Additional Minutes</th>
                                                                                                    <td>10&#162;/min</td>
                                                                                                </tr>
                                                                                            </xsl:if>
                                                                                            <!-- in case the AW customer buys a message pack -->
                                                                                            <xsl:call-template name="aw-messaging-pack-display"/>
                                                                                            <!-- END in case the AW customer buys a message pack -->
                                                                                            <!-- in case the AW customer buys a data pack -->
                                                                                            <xsl:call-template name="aw-data-pack-display"/>
                                                                                            <!-- END in case the AW customer buys a data pack -->
                                                                                            <xsl:if test="boolean(/vmu-page/account-info/lifelineExpiryDate)" >
                                                                                                <tr>
                                                                                                    <th>Service expires on</th>
                                                                                                    <td><xsl:value-of select="/vmu-page/account-info/lifelineExpiryDate" /></td>
                                                                                                </tr>
                                                                                            </xsl:if>
                                                                                        </xsl:when>
                                                                                        <xsl:otherwise>
                                                                                            <tr>
                                                                                                <th>Messaging, Data &amp; Web</th>
                                                                                                <td>
                                                                                                    <xsl:call-template name="choose-plan-msg-data-template">
                                                                                                        <xsl:with-param name="cos" select="$plan-cos"/>
                                                                                                    </xsl:call-template>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </xsl:otherwise>
                                                                                    </xsl:choose>
                                                                                </xsl:otherwise>
                                                                                <!-- END MONTHLY PLANS, INCLUDING AW -->
                                                                            </xsl:choose>

                                                                            </table>

                                                                            <xsl:if test="contains($has-monthly-charges,'true')">
                                                                                <xsl:call-template name="monthly-recurring-charges-display"/>
                                                                                <table cellspacing="0" cellpadding="0" border="0">																																		<tr>
                                                                                    <th colspan="2"><xsl:comment>.</xsl:comment></th>


                                                                                </tr>
                                                                                    <tr>
                                                                                        <th>Total Monthly Charge</th>
                                                                                        <td><xsl:value-of select="/vmu-page/account-info/plan-info/total"/></td>
                                                                                    </tr>
                                                                                </table>
                                                                            </xsl:if>

                                                                            <xsl:if test="contains($has-one-time-charges,'true')">
                                                                                <xsl:call-template name="one-time-charges-display"/>
                                                                            </xsl:if>
                                                                        </div>
                                                                        <div id="account_activity_links" class="col-md-3">
                                                                            <h3>View History For</h3>
                                                                            <ul class="list-unstyled">
                                                                                <li class="mouseout icon_voice"><a class="my_account_overlay" href="/myaccount/accountHistory.do">Calls</a></li>
                                                                                <li class="mouseout icon_msg"><a class="my_account_overlay" href="/myaccount/messaging-history.do">Messages</a></li>
                                                                                <li class="mouseout icon_data"><a class="my_account_overlay" href="/myaccount/dataPlanHistory.do">Data &amp; Web</a></li>
                                                                            </ul>
                                                                            <xsl:if test="$aw-boltons = 'true'">
                                                                                <div class="divder"><xsl:comment>.</xsl:comment></div>
                                                                                <h3>Plan Add-Ons</h3>
                                                                                <ul class="list-unstyled">
                                                                                    <li class="mouseout icon_add"><a class="my_account_overlay" href="/myaccount/prepareAWBolton.do">Manage Add-Ons</a></li>
                                                                                </ul>
                                                                            </xsl:if>
                                                                            <!-- This has to be checked visually -->

                                                                            <!-- END This has to be checked visually -->
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!--This has to be checked visually -->
                                                    <div id="account_promo_area">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <!-- ACCOUNT OVERVIEW: FOR YOUR PHONE -->
                                                                <div id="for_your_phone">
                                                                    <h2>For Your Phone</h2>
                                                                    <xsl:comment>mp_trans_schedule_disable_start</xsl:comment>
                                                                    <!-- <a href="#" class="more">// Phone Details</a> -->

                                                                    <xsl:call-template name="featured-apps">
                                                                        <xsl:with-param name="phone-id" select="$phone-model-string" />
                                                                        <xsl:with-param name="display-mode" select="'1'" />
                                                                    </xsl:call-template>
                                                                    <xsl:comment>mp_trans_schedule_disable_end</xsl:comment>
                                                                </div>						
                                                                <div id="the_latest" class="jcarousel-wrapper">
                                                                    <h2>The Latest</h2>
                                                                    <div id="carousel_control_wrapper"><xsl:comment>.</xsl:comment>
                                                                        <div class="jcarousel-control"><xsl:comment>.</xsl:comment>
                                                                            <xsl:choose> <!-- added for beyond talk with only 2 rotations -->
                                                                                <xsl:when test="$plan-type='beyondtalk' or $plan-type='virginmobile'">
                                                                                    <a href="#">1</a>
                                                                                    <a href="#">2</a>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:choose>
                                                                                        <xsl:when test="$plan-type='paylo' or $plan-type='assurance'">
                                                                                            <!--<a href="#">1</a>
                                                                                            <a href="#">2</a>-->							
                                                                                        </xsl:when>
                                                                                        <xsl:otherwise>
                                                                                            <a href="#">1</a>
                                                                                            <a href="#">2</a>							
                                                                                            <a href="#">3</a>
                                                                                        </xsl:otherwise>
                                                                                    </xsl:choose>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                           </div>
                                                                    </div>
                                                                    <ul>
                                                                        <!-- ACCOUNT OVERVIEW: THE LATEST -->
                                                                        <!-- THE LATEST POSITION 1 -->
                                                                        <xsl:choose>
                                                                            <!-- ACCOUNT OVERVIEW: THE LATEST: POSITION 1: PAYLO RD7 -->
                                                                            <xsl:when test="/vmu-page/login-session/voice-plan-cos = 'COS601' or /vmu-page/login-session/voice-plan-cos = 'COS602'">
                                                                                <li class="mouseout clickable">
                                                                                    <div class="image_hover"><xsl:comment>.</xsl:comment></div>
                                                                                    <img src="${base_url_secure}/_img/myaccount/promos/servicepreserver_250x120.jpg" width="250" height="120" alt="payLo - Service Preserver" />
                                                                                    <h3>One Year of Service</h3>
                                                                                    <p>Keep your service running for an entire year with a single Top-Up.</p>
                                                                                    <!--<a href="http://virginmobileusa.custhelp.com/app/answers/detail/a_id/938/kw/service%20preserver/session/L3RpbWUvMTMwMzE1OTY5Mi9zaWQvUWE0QUFQcms%?intcmp=c-pl-ao-pt2a-rd7servpresr-092811" target="_blank">// LEARN MORE</a> -->
                                                                                    <a href="http://virginmobileusa.custhelp.com/app/answers/detail/a_id/938/session/L3RpbWUvMTMxNzI0NDA1NC9zaWQvQ0NBQ2RmRms/?intcmp=c-pl-ao-pt2a-rd7servpresr-013112">// LEARN MORE</a>
                                                                                </li>
                                                                            </xsl:when>
                                                                            <!-- END PAYLO RD7 -->
                                                                            <!-- ACCOUNT OVERVIEW: THE LATEST: POSITION 1: PAYLO -->
                                                                            <xsl:when test="$plan-type='paylo'">
                                                                                <li class="mouseout clickable">
                                                                                    <div class="image_hover"><xsl:comment>.</xsl:comment></div>
                                                                                    <img src="${base_url_secure}/_img/myaccount/promos/smoothservice_250x120.jpg" width="250" height="120" alt="NEW! The Samsung Entro" />
                                                                                    <h3>Smoother Service</h3>
                                                                                    <p>Register your credit/debit card or PayPal account so you can keep talking without any interruptions.</p>
                                                                                    <a href="${base_url}/help-support/1yearofservice.html?intid=CBM:PL:AO:PT2A:131114:1YoS">// LEARN MORE</a>
                                                                                </li>
                                                                            </xsl:when>
                                                                            <!-- END PAYLO -->
                                                                            <!-- ACCOUNT OVERVIEW: THE LATEST: POSITION 1: EVERYTHING ELSE (AW AND BEYOND TALK) -->  
                                                                            <xsl:otherwise>
                                                                                <li class="mouseout clickable">
                                                                                    <div class="image_hover"><xsl:comment>.</xsl:comment></div>
                                                                                    <img src="${base_url_secure}/_img/myaccount/promos/mingle_250x120.jpg" width="250" height="120" alt="" />
                                                                                    <!--<h3>TAKE WI-FI WITH YOU</h3>-->
                                                                                    <p>
                                                                                        Be the hook up with Mingle&#8212;connect up to 10 Wi-Fi enabled devices. Plans start at $5/day. Nationwide Sprint&#174; 4G LTE Network. No contract. 
                                                                                    </p>
                                                                                    <a href="${base_url}/shop/mobile-broadband/broadband-2-go/netgear-mingle/features/?intid=CBM:BT:AO:PT2A:141003:BB2G:Mingle">// LEARN MORE</a>
                                                                                </li>
                                                                            </xsl:otherwise>
                                                                             <!-- END EVERYTHING ELSE (AW AND BEYOND TALK) -->  
                                                                        </xsl:choose>

                                                                        <!-- THE LATEST POSITION 2 -->
                                                                        <xsl:choose>
                                                                            <!-- ACCOUNT OVERVIEW: THE LATEST: POSITION 2: PAYLO RD7 --> 
                                                                            <xsl:when test="/vmu-page/login-session/voice-plan-cos = 'COS601' or /vmu-page/login-session/voice-plan-cos = 'COS602'">
                                                                                <li class="mouseout clickable">
                                                                                    <div class="image_hover"><xsl:comment>.</xsl:comment></div>
                                                                                    <img src="${base_url_secure}/_img/myaccount/promos/bb2go-4g.jpg" width="250" height="120" alt="NEW! The Ultimate 4G Hookup" />
                                                                                    <h3>Wireless, Whenever</h3>
                                                                                    <p>Plans start at $35/mo. Sprint&#174; 4G Network (where available). No Contract.</p>
                                                                                    <a href="${base_url}/shop/mobile-broadband/broadband-2-go/?intcmp=c-ao-pt2b-bb2go35-080712" target="_blank">// LEARN MORE</a>
                                                                                </li>
                                                                            </xsl:when>
                                                                             <!-- END PAYLO RD7 -->
                                                                             <!-- ACCOUNT OVERVIEW: THE LATEST: POSITION 2: PAYLO  -->
                                                                            <xsl:when test="$plan-type='paylo'">
                                                                            </xsl:when>
                                                                            <!-- END PAYLO -->
                                                                            <!-- ACCOUNT OVERVIEW: THE LATEST: POSITION 2: BEYOND TALK --> 
                                                                            <xsl:when test="$plan-type='beyondtalk' or $plan-type='virginmobile'">
                                                                                <li class="mouseout clickable">
                                                                                    <div class="image_hover"><xsl:comment>.</xsl:comment></div>
                                                                                    <img src="${base_url_secure}/_img/myaccount/promos/supreme_bigpicture_250x120.jpg" width="250" height="120" alt="" />
                                                                                    <h3>The Big Picture</h3>
                                                                                    <p>Introducing Supreme&#8482;. Available exclusively on Virginmobileusa.com</p>
                                                                                    <a href="${base_url}/shop/cell-phones/supreme-phone/features/?intid=CBM:BT:AO:PT2B:131114:BT:PhoneLaunch:Supreme:GIN">// GET IT NOW</a>
                                                                                </li>
                                                                            </xsl:when>
                                                                            <!-- END BEYOND TALK -->
                                                                            <!-- ACCOUNT OVERVIEW: THE LATEST: POSITION 2: EVERYTHING ELSE --> 
                                                                            <xsl:otherwise>
                                                                                <xsl:comment>.</xsl:comment>
                                                                            </xsl:otherwise>
                                                                            <!-- END EVERYTHING ELSE --> 
                                                                        </xsl:choose>
                                                                    </ul>
                                                                </div>						
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-2 column_narrow">
                                                    <div class="acct_nav">
                                                        <h2 class="hdl_section_title" id="hdl_iwantto">I Want To...</h2>
                                                        <ul>
                                                            <!-- Upfront and Regular Insurance -->
                                                            <xsl:choose>
                                                                <xsl:when test="$insurance-link-type='show-applecare-signup' and normalize-space(/vmu-page/account-info/needs-curing) != 'true' and normalize-space(/vmu-page/account-info/past-current) !='true'">
                                                                    <li class="my_account_overlay">
                                                                        <h3><a href="/myaccount/prepareDeviceInsurance.do">Add AppleCare+</a></h3>
                                                                        <p>Add AppleCare+ for $99</p>
                                                                    </li>
                                                                </xsl:when>
                                                                <xsl:when test="$insurance-link-type='show-regular-signup'">
                                                                    <li class="my_account_overlay">
                                                                        <h3><a href="/myaccount/prepareDeviceInsurance.do">Enroll in Phone Insurance</a></h3>
                                                                        <p>Coverage in the event of device loss, theft or damage.<!--Stop worrying -  peace of mind for just <xsl:call-template name="format-price"><xsl:with-param name="price-to-format"><xsl:value-of select="$insurance-raw-price"/></xsl:with-param><xsl:with-param name="digit-template">0</xsl:with-param></xsl:call-template>/month.--></p>
                                                                    </li>
                                                                </xsl:when>
                                                                <xsl:when test="$insurance-link-type='show-regular-edit'">
                                                                    <li class="my_account_overlay">
                                                                        <h3><a href="/myaccount/prepareDeviceInsurance.do">Edit Phone Insurance Settings</a></h3>
                                                                        <p>Manage, modify, or suspend your current insurance.</p>
                                                                    </li>
                                                                </xsl:when>
                                                            </xsl:choose>
                                                            <!-- End Upfront and Regular Insurance -->
                                                            <!-- Hotspot -->
                                                            <xsl:if test="/vmu-page/account-info/hotspot-eligible = 'true'">
                                                                <li class="my_account_overlay">
                                                                    <h3><a href="/myaccount/prepareHotspotService.do">
                                                                        Manage Mobile Hotspot</a></h3>
                                                                    <p>Make your phone a mobile hotspot.</p>
                                                                </li>
                                                            </xsl:if>
                                                            <!-- End Hotspot -->
                                                            <!-- International Offer -->
                                                            <xsl:if test="$can-have-internationals = 'true' and normalize-space(/vmu-page/account-info/needs-curing) != 'true' and normalize-space(/vmu-page/account-info/past-current) !='true'">
                                                                <li class="my_account_overlay">
                                                                    <h3><a href="/myaccount/manageInternationalOffer.do">
                                                                        Manage International Services</a></h3>
                                                                    <p>Save when calling to Mexico and around the globe with international offers.</p>
                                                                </li>
                                                            </xsl:if>
                                                            <!-- End International Offer -->
                                                            <!-- Additional Offers -->
                                                            <xsl:if test="$can-have-additional-offers = 'true' and normalize-space(/vmu-page/account-info/needs-curing) != 'true' and normalize-space(/vmu-page/account-info/past-current) !='true'">
                                                                <li class="my_account_overlay">
                                                                    <h3><a href="/myaccount/manageAdditionalOffer.do">

                                                                        Manage Other Offers</a></h3>
                                                                    <p>Make changes to your products &amp; services.</p>
                                                                </li>
                                                            </xsl:if>
                                                            <!-- End Additional Offers -->
                                                            <xsl:if test="/vmu-page/account-info/advance-payment/@enabled = 'true'">
                                                                <li class="my_account_overlay active">
                                                                    <h3><a href="/myaccount/prepareAdvancePayment.do">Pay Now</a></h3>
                                                                    <p style="display:block">Pay by credit/debit, PayPal, or Top-Up card.</p>
                                                                </li>
                                                            </xsl:if>
                                                            <xsl:choose>
                                                                <xsl:when test="$aw-boltons = 'true'">
                                                                    <li class="my_account_overlay">
                                                                        <h3><a href="/myaccount/prepareAWBolton.do">Manage Plan Add-Ons</a></h3>
                                                                        <p>Buy additional minutes and texts and add them to your monthly plan.</p>
                                                                    </li>
                                                                </xsl:when>
                                                            </xsl:choose>
                                                            <!-- I'm removing the conditional logic that prevented the change plan link from being visible for COS211 -->
                                                            <xsl:if test="$plan-cos != 'COS807'">
                                                                <li class="my_account_overlay">
                                                                    <h3><a href="/myaccount/migrationOverview.do">Change My Plan</a></h3>
                                                                    <p>Choose the plan that fits you best.</p>
                                                                </li>
                                                            </xsl:if>
                                                            <xsl:if test="$plan-cos = 'COS199'">
                                                                <li class="my_account_overlay">
                                                                    <h3><a href="/myaccount/prepareAutoRollForwardSettings.do">Edit Auto Rollforward Settings</a></h3>
                                                                    <p>Automatically add a new Minute Pack to your account 30 days after your last Minute Pack purchase.</p>
                                                                </li>
                                                            </xsl:if>
                                                            <!-- Restart -->
                                                            <xsl:choose>
                                                                <xsl:when test="/vmu-page/account-info/restart-plan/@status='true' and ($plan-cos != 'COS402' or $plan-cos != 'COS405')">
                                                                    <xsl:choose>
                                                                        <xsl:when test="$plan-type='assurance'">
                                                                            <!-- <li class="my_account_overlay">
                                                                          <h3>Restart My Plan Month</h3>
                                                                          <p> 
                                                                            Add money to your account today by Topping-Up and you'll have more minutes for talking or texting.</p>
                                                                        </li> -->
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <li class="my_account_overlay">
                                                                                <h3><a>
                                                                                    <xsl:attribute name="href"><xsl:value-of select="/vmu-page/account-info/restart-plan/restart-link"/></xsl:attribute>
                                                                                    <xsl:attribute name="transaction"><xsl:value-of select="/vmu-page/account-info/restart-plan/restart-link/@transaction"/></xsl:attribute>
                                                                                    Restart My Plan Month
                                                                                </a>
                                                                                </h3>
                                                                                <p><!--<strong> Running low on minutes?</strong><br/>-->
                                                                                    Pay your monthly charge today and get a whole new
                                                                                    set of minutes.
                                                                                </p>
                                                                            </li>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </xsl:when>
                                                            </xsl:choose>

                                                            <li class="my_account_overlay">
                                                                <h3><a href="/myaccount/accountHistory.do">Account History</a></h3>
                                                                <p>Keep track of calls, messages, Top-Ups, and everything else.</p>
                                                            </li>
                                                            <li class="my_account_overlay">
                                                                <h3><a href="/myaccount/prepareUserInformation.do">Edit My Contact Info</a></h3>
                                                                <p>Married? Moved? Updating your info is quick and easy.</p>
                                                            </li>
                                                            <li class="my_account_overlay">
                                                                <h3><a href="/myaccount/preparePhoneSwap.do">Swap Phones</a></h3>
                                                                <p>New phone? Great. Let's get you set up.</p>
                                                            </li>
                                                            <li class="my_account_overlay">
                                                                <h3><a href="/myaccount/orderHistory.do">View Order History</a></h3>
                                                                <p>Keep track of open orders &amp; purchases.</p>
                                                            </li>
                                                        </ul>

                                                    </div>

                                                </div>
                                                <xsl:if test="$plan-type != 'assurance'">
                                                    <div id="ad1c" class="clickable">
                                                        <a href="https://refer.virginmobileusa.com/public/home.pg?intid=CBM:AO:PT3:140311:Refer:LM" target="_blank">
                                                            <img src="${base_url_secure}/_img/myaccount/referafriend-accountoverview-10bonus.gif" alt="refer a friend"/>
                                                            <!--<img src="${base_url_secure}/_img/myaccount/referafriend-accountoverview.gif" alt="refer a friend"/>-->
                                                        </a>

                                                    </div>
                                                </xsl:if>
                                                <xsl:if test="$plan-type = 'assurance' and $aw-boltons='true'">
                                                    <div id="ad1" class="slider_ad clickable">
                                                        <a href="/myaccount/prepareAWBolton.do" class="stage collapsed my_account_overlay">
                                                            <span id="ad1_foreground"><img src="${base_url_secure}/_img/myaccount/ad_20_fore.gif" alt="" /></span>
                                                            <span id="ad1_collapsed"><img src="${base_url_secure}/_img/myaccount/ad_20_col.gif" alt="" /></span>
                                                            <span id="ad1_expanded"><img src="${base_url_secure}/_img/myaccount/ad_20_exp.gif" alt="" /></span>
                                                        </a>
                                                    </div>
                                                </xsl:if>
                                            </div>
										</div>
								    </div>
								</div>
							</div>
							
							<div class="tabContent clearfix bt_phone hidingblocks" id="pa">
								<h2 class="hdl_page_title" id="hdl_phoneappsandmore">Phone, Apps &amp; More</h2>
								<div class="row">
									<div class="col-md-12">
										<div class="well" id="pa_container">
											<div class="row">
												<div class="col-md-4">
													<div class="phone">
														 <xsl:call-template name="phone-image-display">
															<xsl:with-param name="sku-string" select="$phone-model-string"/>
															<xsl:with-param name="display-context">myaccount</xsl:with-param>
														</xsl:call-template>
			
														<div>
															<xsl:attribute name="class">
																<xsl:text>plan_details</xsl:text>
																<xsl:if test="/vmu-page/account-info/hi-add-on/@flag='true'"><xsl:text> phone_insurance_info</xsl:text></xsl:if>
															</xsl:attribute>
															<xsl:call-template name="phone-name-display">
																<xsl:with-param name="sku-string" select="$phone-model-string"/>
																<xsl:with-param name="display-context">myaccount</xsl:with-param>
															</xsl:call-template>
															<p class="tel"><xsl:value-of select="/vmu-page/account-info/formatted-min"/></p>
															<xsl:if test="/vmu-page/account-info/hi-add-on/@flag='true'">
																<div>
																	<strong>
																		<xsl:text>Phone Insurance: </xsl:text>
																		<xsl:choose>
																			<xsl:when test="/vmu-page/account-info/hi-add-on/active-add-on/status = 'Active' or /vmu-page/account-info/hi-add-on/active-add-on/status = 'Expired'">Yes</xsl:when>
																			<xsl:otherwise>No</xsl:otherwise>
																		</xsl:choose>
																	</strong><br />
																	<a class="my_account_overlay" href="/myaccount/prepareHIAddon.do">
																		<xsl:choose>
																			<xsl:when test="/vmu-page/account-info/hi-add-on/active-add-on/status = 'Active' or /vmu-page/account-info/hi-add-on/active-add-on/status = 'Expired'">Edit Settings</xsl:when>
																			<xsl:otherwise>Get It Now</xsl:otherwise>
																		</xsl:choose>
																	</a>
																</div>
															</xsl:if>
														</div>
													</div>
													<div id="ratings_callout" class="clickable mouseout">
														<h3 class="">Speak Your Mind</h3>

														<p class="noshow">Help your fellow shoppers by giving your opinion on Virgin Mobile stuff.</p>
														<p><a href="${base_url}/ratings-and-reviews">// Write a Review</a></p>
													</div>
													<div class="acct_nav">
														<ul>
															<li class="clickable">
																<h3><a class="howToGuide" href="#">How-To Guide</a></h3>
																<p>A virtual guide to your phone's features.</p>
															</li>
															<li class="clickable">
																<h3><a id="manual_link" target="_blank" href="#">Download Phone Manual</a></h3>
																<p>Find out all you'll ever need to know about your phone.</p>
															</li>
															<li class="clickable">
																<h3><a id="faq_link" href="#">Phone FAQs</a></h3>
																<p>Have a question? See if it's already been asked &amp; answered.</p>
															</li>
															<li class="my_account_overlay">
																<h3><a href="/myaccount/minSwap.do">Change Phone Number</a></h3>
																<p>Want a new number? Just give us your current zip code.</p>
															</li>
															<li class="my_account_overlay">
																<h3><a href="/myaccount/preparePhoneSwap.do">Swap Phone</a></h3>
																<p>New phone? Great. Let's get you set up.</p>
															</li>
														  
															<li class="clickable">
																<h3><a href="/myaccount/lostPhone.do">I Lost My Phone</a></h3>
																<p>Suspend service right away &amp; track down last night's cab.</p>
															</li>
														   <!-- <li class="clickable">
																<h3><a href="/myaccount/brokePhone.do">I Broke My Phone</a></h3>
																<p>Get a replacement phone.</p>
															</li> -->
															<li class="my_account_overlay">
																<h3><a href="/myaccount/textMessagingHome.do">Edit Message Settings</a></h3>
																<p>Block messages from your crazy ex or disable texts entirely.</p>
															</li>
														</ul>
													</div>
	
													<!--<div id="ad2" class="slider_ad">
														<xsl:if test="/vmu-page/account-info/hi-add-on/@flag='true' and /vmu-page/account-info/hi-add-on/active-add-on/status != 'Active'">
															<a class="my_account_overlay stage collapsed" href="/myaccount/prepareHIAddon.do">
																<span id="ad2_foreground"><img src="${base_url_secure}/_img/myaccount/ad_insleft_fore.gif" alt="" /></span>
																<span id="ad2_collapsed"><img src="${base_url_secure}/_img/myaccount/ad_insleft_col.gif" alt="" /></span>
																<span id="ad2_expanded"><img src="${base_url_secure}/_img/myaccount/ad_insleft_exp.gif" alt="" /></span>
															</a>
														</xsl:if>				
														<xsl:comment>.</xsl:comment>					
													</div>-->
												</div>
										
												<div class="col-md-8">
													<div class="row">
														<div class="col-md-12">
															<!-- PHONE, APPS, AND MORE: FOR YOUR PHONE -->
															<div id="featured_downloads"  style="height:500px;">
																<h2>For Your Phone</h2>
																<xsl:comment>mp_trans_schedule_disable_start</xsl:comment>
																<xsl:call-template name="featured-apps2">
																	<xsl:with-param name="phone-id" select="$phone-model-string" />
																	<xsl:with-param name="display-mode" select="'2'" />
																</xsl:call-template>
																<xsl:comment>mp_trans_schedule_disable_end</xsl:comment>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="tabContent clearfix bt_phone hidingblocks" id="sp">
								<h2 class="hdl_page_title" id="hdl_settingsandpreferences">Settings &amp; Preferences</h2>
								
								<xsl:if test="$mrc-discount='eligible' or $mrc-discount='applied' or $mrc-warning-to-320-autopay='true' or $mrc-warning-to-or-on-320-noautopay='true' or $mrc-warning-from-320='true'">
								<div class="row">
									<div class="col-md-12">
										<xsl:choose>
											<xsl:when test="$mrc-warning-to-320-autopay='true'">
												<div class="alert alert-warning" style="background-image:none;padding:10px 10px;text-align:center">
													<p style="font-size:12px;margin-bottom:0px;">The $5 Auto Pay discount for iPhone is not applicable for the $20 plan.</p>
													
													<p style="font-size:12px;font-size:12px;margin-bottom:0px;">*Your Next Month's Charge amount is $20. The correct amount will be charged at the time your Monthly Charge is due.</p>
												</div>
											</xsl:when>
											<xsl:when test="$mrc-warning-to-or-on-320-noautopay='true'">
												<div class="alert alert-warning" style="background-image:none;padding:10px 10px;text-align:center">
													<p style="font-size:12px;margin-bottom:0px;">The $5 Auto Pay discount for iPhone is not applicable for the $20 plan.</p>
													
													
												</div>
											</xsl:when>
											<xsl:when test="$mrc-discount='eligible' or $mrc-warning-from-320='true'">
												<xsl:call-template name="mrc-discount-promos">
													<xsl:with-param name="context">myaccount-sp</xsl:with-param>
												</xsl:call-template>
											</xsl:when>
										</xsl:choose>
									</div>
								</div>
								</xsl:if>
								<div class="row">		
									<div class="col-md-12">
										<div id="settings_container">
											<div class="row">
												<div class="col-md-9">
													<div class=" column_wide">
														<div id="payment_method">
															<div class="row">
																<div class="col-md-6" id="current_payment_method">
																	<h2>Current Payment Method</h2>
																	<xsl:choose>
																		<!-- Credit Card -->
																		<xsl:when test="/vmu-page/account-info/payment-method/cc-flag = 'true'">
																			<div class="table_wrapper">
																				<xsl:if test="$mrc-discount='eligible' or $mrc-discount='applied'">
																					<xsl:attribute name="style">top:60px;</xsl:attribute>
																				</xsl:if>
																				<table cellpadding="0" border="0">
																					<tr>
																						<th>Payment Method</th>
																						<td>
																							<xsl:call-template name="credit-card-number-display">
																								<xsl:with-param name="cc-string"><xsl:value-of select="/vmu-page/account-info/payment-method/last-four-cc-number"/></xsl:with-param>
																								<xsl:with-param name="cc-type"><xsl:value-of select="/vmu-page/account-info/payment-method/cc-type"/></xsl:with-param>
																							</xsl:call-template>
																						</td>
																					</tr>
																					
																					<xsl:if test="$paylo-monthly='true' or $plan-type='beyondtalk' or $plan-type='virginmobile'">
																						<tr>
																							<td colspan="2" class="registration_info">
																								<xsl:choose>
																								  <xsl:when test="/vmu-page/account-info/payment-method/rpv-preferred-mrc = 'true'">
																								  	This card will be used to pay any future monthly charges. <a class="my_account_overlay" href="/myaccount/prepareCreditCardInformation.do">Click here</a> to change your settings.
																								  </xsl:when>
																								  <xsl:otherwise>
																								  	This card will be saved for future use. Log in each month to pay or <a class="my_account_overlay" href="/myaccount/prepareCreditCardInformation.do">click here</a> to change your settings.
																								  </xsl:otherwise>
																							  </xsl:choose>
																							</td>
																						</tr>
																					</xsl:if>	
																				</table>
																			</div>
																		</xsl:when>
																		<!-- Paypal -->
																		<xsl:when test="/vmu-page/account-info/payment-method/paypal-flag = 'true'">
																			<div class="payment_method" id="payment_method_paypal">PayPal</div>
																			<xsl:if test="$paylo-monthly='true' or $plan-type='beyondtalk' or $plan-type='virginmobile'">
																				<div class="payment_method" id="payment_method_paypal2">
																					<xsl:choose>
																						<xsl:when test="/vmu-page/account-info/payment-method/rpv-preferred-mrc = 'true'">
																							This account will be used to pay any future monthly charges. <a class="my_account_overlay" href="/myaccount/preparePayPal.do">Click here</a> to change your settings.
																						</xsl:when>
																						<xsl:otherwise>
																							This account will be saved for future use. Log in each month to pay or <a class="my_account_overlay" href="/myaccount/preparePayPal.do">click here</a> to change your settings.
																						</xsl:otherwise>
																					</xsl:choose>
																				</div>
																			</xsl:if>
																		</xsl:when> 
																		<!-- Cash/Check -->
																		<xsl:otherwise>
																			<div class="payment_method" id="payment_method_cash">
																				Cash
																			</div>
																		</xsl:otherwise>
																	</xsl:choose>
																</div>
																<div class="col-md-6">
																	<div id="current_payment_method_settings">
																		<h3>Change Payment Type</h3>
																		<p>Add a new credit/debit card or PayPal account.</p>
																		<a class="my_account_overlay" style="line-height:20px" href="/myaccount/prepareCreditCardInformation.do">
																			<xsl:choose>
																				<xsl:when test="/vmu-page/account-info/payment-method/cc-flag = 'true'">// Edit Credit Card Settings</xsl:when>
																				<xsl:otherwise>// Use Credit Card</xsl:otherwise>
																			</xsl:choose>
																		</a>
																		<br/>
																		<a class="my_account_overlay" style="line-height:20px" href="/myaccount/preparePayPal.do">
																			<xsl:choose>
																				<xsl:when test="/vmu-page/account-info/payment-method/paypal-flag = 'true'">// Edit PayPal Settings</xsl:when>
																				<xsl:otherwise>// Use PayPal Account</xsl:otherwise>
																			</xsl:choose>
																		</a>
																		<!-- AUTO TOP-UP SETTINGS -->
																		<!-- as per FEA/VDS, need to hide auto top-up settings link from all monthly customers -->
																		<xsl:if test="$display-auto-top-up='true'">
																			<h3>Change Auto Top-Up Settings</h3>
																			<p>
																				<xsl:choose>
																					<xsl:when test="/vmu-page/account-info/topup-settings/@has-auto-topup = 'true'">
																						<xsl:text>You've registered to Top-Up $</xsl:text><xsl:value-of select="/vmu-page/account-info/topup-settings/amount"/>
																						<xsl:choose>
																							<xsl:when test="/vmu-page/account-info/topup-settings/frequency/@value = 'lowbalance'">
																								<xsl:text> whenever your cash balance drops below $5.</xsl:text>
																							</xsl:when>
																							<xsl:when test="/vmu-page/account-info/topup-settings/frequency/@value = '30days'">
																								<xsl:text> every month on the following day: </xsl:text><xsl:value-of select="/vmu-page/account-info/topup-settings/frequency/day-of-month"/><xsl:text>.</xsl:text>
																							</xsl:when>
																							<xsl:when test="/vmu-page/account-info/topup-settings/frequency/@value = '90days'">
																								<xsl:choose>
																									<xsl:when test="$plan-cos = 'COS601' or $plan-cos='COS602'">
																										<xsl:text> on my service renewal date.</xsl:text>
																									</xsl:when>
																									<xsl:otherwise>
																										<xsl:text> once every 90 days.</xsl:text>
																									</xsl:otherwise>
																								</xsl:choose>
																							</xsl:when>
																							<xsl:otherwise>
																								<xsl:value-of select="/vmu-page/account-info/topup-settings/frequency/@value"/><xsl:text>.</xsl:text>
																							</xsl:otherwise>
																						</xsl:choose>
																					</xsl:when>
																					<xsl:otherwise>
																						Set Auto Top-Up and never worry about running out of money for all your extras.
																					</xsl:otherwise>
																				</xsl:choose>
																			</p>										
																			<a class="my_account_overlay" style="line-height:20px" href="/myaccount/prepareAutoTopup.do">// Edit Now</a>
																		</xsl:if>
																		<!-- END AUTO TOP-UP SETTINGS -->
																	</div>
																</div>	
															</div>
													
														</div>
														
														<div  id="promo_area">
															<div class="row">
																<div class="col-md-6" id="edit_your_contact_info">
																	<h3 class="hdl_section_title">Edit Your Contact Info</h3>
																	
																		<p>Married? Moved? Updating your info is quick and easy.</p>
																		<a class="my_account_overlay" href="/myaccount/prepareUserInformation.do">// Edit Now</a>
																	
																</div>						
																<div class="col-md-6" id="change_account_pin">
																	<h3 class="hdl_section_title">Change My Account PIN</h3>
																	<div class="iconpromo" id="sp-icon-security">
																		<p>Change it to something you'll never forget.</p>
																		<a class="my_account_overlay" href="/myaccount/prepareAccountSettings.do">// Change Now</a>
																	</div>
																</div>
														
															</div>
														</div>
														
													</div>
												</div>
												<div class="col-md-2 column_narrow">
													
																<div class="acct_nav">
																	<h2 class="hdl_section_title" id="hdl_iwantto">I Want To...</h2>
																	<ul>
																		<li class="my_account_overlay">
																			<h3><a href="/myaccount/prepareUserInformation.do">Edit Contact Info</a></h3>
																			<p>Married? Moved? Updating your info is quick and easy.</p>
																		</li>
																		<!-- removing auto top-up settings for monthly customers per FEA/VDS -->
																		<xsl:if test="$display-auto-top-up='true'">
																		<li class="my_account_overlay">
																			<h3><a href="/myaccount/prepareAutoTopup.do">Edit Auto-Topup Settings</a></h3>
																			<p>Top-Up automatically to keep your account current.</p>
																		</li>
																		</xsl:if>
																		<!-- end removing auto top-up settings for monthly customers per FEA/VDS -->
																		<li class="my_account_overlay">
																			<h3><a href="/myaccount/prepareAccountSettings.do">Change My Account PIN</a></h3>
																			<p>Change it to something you'll never forget.</p>
																		</li>
																		<xsl:if test="$plan-cos != 'COS807' and $plan-cos != 'COS809'"> 
																			<li class="my_account_overlay">
																				<h3><a href="/myaccount/migrationOverview.do">Change Plan</a></h3>
																				<p>Choose the plan that fits you best.</p>
																			</li>
																		</xsl:if>
																		<xsl:if test="$plan-cos = 'COS199'">
																			<li class="my_account_overlay">
																				<h3><a href="/myaccount/prepareAutoRollForwardSettings.do">Edit Auto Rollforward Settings</a></h3>
																				<p>Automatically add a new Minute Pack to your account 30 days after your last Minute Pack purchase.</p>
																			</li>
																		</xsl:if>
																		<li class="my_account_overlay">
																			<h3><a href="/myaccount/accountHistory.do">Account Activity</a></h3>
																			<p>Keep track of calls, messages, Top-Ups, and everything else.</p>
																		</li>
																		<li class="my_account_overlay">
																			<h3><a href="/myaccount/minSwap.do">Change Phone Number</a></h3>
																			<p>Want a new number? Just give us your current zip code.</p>
																		</li>
																		<li class="my_account_overlay">
													<h3><a href="/myaccount/youServiceSettings.do">Edit Service Settings</a></h3>
																			<p>Manage mobile ad and reporting preferences, caller ID and all other settings
																			</p>
																		</li>
																		<li class="my_account_overlay">
																			<h3><a href="/myaccount/preparePhoneSwap.do">Change Phone</a></h3>
																			<p>New phone? Great. Let's get you set up.</p>
																		</li>
																		<li class="my_account_overlay">
																			<h3><a href="/myaccount/orderHistory.do">View My Order History</a></h3>
																			<p>Keep track of open orders &amp; purchases.</p>
																		</li>
																	</ul>
																</div>
														
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
			
							<div class="tabContent clearfix bt_phone hidingblocks" id="pl">
								<h2 class="hdl_page_title" id="hdl_programsandthelatest">Programs &amp; The Latest</h2>
								<div class="row">
									<div class="col-md-12">
										<div class="well" id="the_latest_container">
											<div class="row">
												<div id="the_latest_wide">
													
													<h2>The Latest</h2>
													<!--<a href="#" class="more">// See Everything We're Up To</a>-->
													
													<ul>
														
														<!-- PROGRAMS THE LATEST POSITION 1 -->
														<xsl:choose>
															<!-- ASSURANCE WIRELESS NO SKIN -->
															<xsl:when test="/vmu-page/login-session/voice-plan-cos = 'COS211'">
																<!--<li class="mouseout clickable">
													<img src="${base_url_secure}/_img/myaccount/promos/louis_barajas_170x90.jpg" width="170" height="90" alt="" />
													<h3>LOUIS BARAJAS</h3>
													<p>Assurance Wireless has teamed up with Financial Expert and Author Louis Barajas to help educate and empower people to better manage their resources during these difficult economic times.</p>
													<a href="http://www.louisbarajas.com/MeetLouis/tabid/60/Default.aspx" target="_blank">// Learn More</a>
												</li> -->
															</xsl:when>
															<!-- END ASSURANCE WIRELESS NO SKIN -->
															
															<!-- PROGRAMS AND THE LATEST: THE LATEST: POSITION 1: PAYLO RD7 -->
															<xsl:when test="/vmu-page/login-session/voice-plan-cos = 'COS601' or /vmu-page/login-session/voice-plan-cos = 'COS602'">
																<li class="my_account_overlay clickable2 mouseout">
																	<img src="${base_url_secure}/_img/myaccount/promos/rpv_170x90.jpg" width="170" height="90" alt="" />
																	<h3>Smoother Service</h3>
																	<p>Register your credit/debit card or PayPal account so you can keep talking without any interruptions.</p>
																	<a href="/myaccount/prepareCreditCardInformation.do?intcmp=c-pl-pl-pt1a-rd7rpv-013112">// Learn More</a>
																</li>
															</xsl:when>
															<!-- END PAYLO RD7 -->
															
															<!-- PROGRAMS AND THE LATEST: THE LATEST: POSITION 1: PAYLO -->
															<xsl:when test="$plan-type='paylo'">
																<!--<li class="clickable mouseout">
													<img src="${base_url_secure}/_img/myaccount/promos/4g-on-the-fly_170x90.jpg" width="170" height="90" alt="" />
													<h3>4G ON THE FLY</h3>
													<p>Connect your tablet, laptop, and other wireless devices. Wi-Fi, Whenever. Plans start at $5. Sprint&#174; 4G (WiMAX) Network. No Contract.</p>
													<a href="${base_url}/mobile-broadband-plans/broadband-2-go/overview/?intcmp=c-pl-pt1a-bb2go-031813">// Learn More</a>
												</li>-->
																<li class="clickable mouseout">
																	<img src="${base_url_secure}/_img/myaccount/promos/buyback_getthegreen_170x90.jpg" width="170" height="90" alt="" />
																	<h3>GET THE GREEN YOU NEED FOR THE PHONE YOU WANT #BUYBACK</h3>
																	<p>You can earn up to $300 in account credit when you recycle your old phone with Virgin Mobile Buyback.</p>
																	<a href="https://buyback.virginmobileusa.com/vmb/?intid=CBM:PL:PL:PT1A:131114:BT:BuyBack:LM">// Learn More</a>
																</li>
															</xsl:when>
															<!-- END PAYLO -->
															
															<!-- PROGRAMS AND THE LATEST: THE LATEST: POSITION 1: ALL BEYOND TALK  -->
															<xsl:when test="$plan-type='beyondtalk' or $plan-type='virginmobile'">
																<!--<li class="mouseout clickable">
																	<img src="${base_url_secure}/_img/myaccount/promos/triumph_170x90.jpg" width="170" height="90" alt="" />
																	<h3>Save on a New Smartphone</h3>
																	<p>Get the Android&#8482;-powered Motorola Triumph for $279.99. Featuring a 4.1" touchscreen and 5MP camera.</p>
																	<a href="${base_url}/cell-phones/motorola-triumph-phone.jsp?intcmp=c-bt-pl-pt1a-triumph-013112">// Learn More</a>
																</li>-->
																<!--<li class="mouseout clickable">
																	<img src="${base_url_secure}/_img/myaccount/promos/fin-services_170x90.jpg" width="170" height="90" alt="" />
																	<h3>New: Financial Services</h3>
																	<p>Pay your utility bills and add funds to a loved one's mobile. Do it all from your Virgin Mobile phone.</p>
																	<a href="http://virginmobileusa.custhelp.com/app/answers/detail/a_id/5666/kw/financial%20services/?intcmp=c-pl-pt1a-mcomm-060512">// Learn More</a>
																</li>-->
																<!--<li class="mouseout clickable">
																	<img src="${base_url_secure}/_img/myaccount/promos/money-center_250x120.jpg" width="170" height="90" alt="" />
																	<h3>Money Center</h3>
																	<p>Recharge an international mobile phone,  pay bills or transfer money internationally...all from your phone.</p>
																	<a href="http://virginmobileusa.custhelp.com/app/answers/detail/a_id/5741/kw/international%20money%20transfer?intcmp=c-pl-pt1a-moneyctr-031813">// Learn More</a>
																</li>-->
																
																<li class="clickable mouseout">
																	<img src="${base_url_secure}/_img/myaccount/promos/international_170x90.jpg" width="170" height="90" alt="" />
																	<h3>LIVE WITHOUT BORDERS</h3>
																	<p>Virgin Mobile's new international offers let you stay connected with family and friends across the globe, because you shouldn't have to miss a thing no matter the distance.</p>
																	<a href="${base_url}/cell-phone-plans/international-phone-plans-rates/?intid=CBM:BT:PL:PT1A:141003:BT:IntlRTS">// Learn More</a>
																</li>
																
															</xsl:when>
															<!-- END ALL BEYOND TALK  -->
															
															<!-- PROGRAMS AND THE LATEST: THE LATEST: POSITION 1: EVERYTHING ELSE  -->
															<xsl:otherwise>
																<li class="mouseout clickable">
																	<img src="${base_url_secure}/_img/myaccount/promos/handsetinsurance_170x90.jpg" width="170" height="90" alt="" />
																	<h3>PHONE INSURANCE</h3>
																	<p>Protect your phone in case of loss, theft, or damage.</p>
																	<a href="${base_url}/phone-insurance" target="_blank">// Learn More</a>
																</li>
															</xsl:otherwise>
														</xsl:choose>
														<!-- END EVERYTHING ELSE  -->
														
														<!-- PROGRAMS THE LATEST POSITION 2 -->
														<xsl:choose>
															
															<!--PROGRAMS AND THE LATEST: THE LATEST: POSITION 2: PAYLO RD7  -->
															<xsl:when test="/vmu-page/login-session/voice-plan-cos = 'COS601' or /vmu-page/login-session/voice-plan-cos = 'COS602'">
																<li class="mouseout clickable">
																	<img src="${base_url_secure}/_img/myaccount/promos/lost_phone_170x90.jpg" width="170" height="90" alt="" />
																	<h3>Lost Your Phone?</h3>
																	<p>Don't panic. Let us know so we can secure your balance.</p>
																	<a href="/myaccount/lostPhone.do?intcmp=c-pl-pl-pt1b-rd7lostphone-013112">// Learn More</a>
																</li>
															</xsl:when>
															<!-- END PAYLO RD7  -->
															
															
															<!-- PROGRAMS AND THE LATEST: THE LATEST: POSITION 2: PAYLO  -->
															<xsl:when test="$plan-type='paylo'">
																<!--<li class="mouseout clickable">
													<img src="${base_url_secure}/_img/myaccount/promos/lost_phone_170x90.jpg" width="170" height="90" alt="" />
													<h3>Lost Your Phone?</h3>
													<p>Don't panic. Let us know so we can secure your balance.</p>
													<a href="/myaccount/lostPhone.do?intcmp=c-pl-pl-pt1b-lostphone-013112">// Learn More</a>
												</li>-->
																<li class="mouseout clickable">
																	<img src="${base_url_secure}/_img/myaccount/promos/rpv_170x90.jpg" width="170" height="90" alt="" />
																	<h3>KEEP YOUR SERVICE WORKING THE EASY WAY</h3>
																	<p>Register a credit/debit card or PayPayl account and sign up for Auto Top-Up.</p>
																	<a href="/myaccount/prepareCreditCardInformation.do?intid=CBM:PL:PL:PT1B:130829:RPV">// Learn More</a>
																</li>
															</xsl:when>
															<!-- END PAYLO  -->
															
															<!-- PROGRAMS AND THE LATEST: THE LATEST: POSITION 2: ALL BEYOND TALK  -->
															<xsl:when test="$plan-type='beyondtalk' or $plan-type='virginmobile'">
																<!--<li class="clickable mouseout">
																	<img src="${base_url_secure}/_img/myaccount/promos/buyback_getthegreen_170x90.jpg" width="170" height="90" alt="" />
																	<h3>GET THE GREEN YOU NEED FOR THE PHONE YOU WANT #BUYBACK</h3>
																	<p>You can earn up to $300 in account credit when you recycle your old phone with Virgin Mobile Buyback.</p>
																	<a href="https://buyback.virginmobileusa.com/vmb/?intid=CBM:BT:PL:PT1B:131114:BT:BuyBack:LM">// Learn More</a>
																</li>-->
																<li class="clickable mouseout">
																	<img src="${base_url_secure}/_img/myaccount/promos/samsunggs5_170x90.jpg" width="170" height="90" alt="" />
																	<h3>THE NEXT BIG THING. JUST GOT BETTER.</h3>
																	<p>The Samsung Galaxy S&#174; 5 on Virgin Mobile</p>
																	<a href="${base_url}/shop/cell-phones/samsung-galaxy-S5-4G-LTE-phone/features/?intid=CBM:BT:PL:PT1B:141003:BT:Phone:SamsungGalaxy5">// Get It Now</a>
																</li>
																
																
															</xsl:when>
															<!-- END ALL BEYOND TALK  -->
															<xsl:when test="$plan-type='assurance'">
															<li class="mouseout clickable">
																<img src="${base_url_secure}/_img/myaccount/aw-testimonials_170x90.png" width="170" height="90" alt="" />
																<h3>TESTIMONIALS</h3>
																<p>Has Assurance Wireless helped you stay in touch with employment, health services, family and friends? <a href="http://newsroom.assurancewireless.com/webform/let-us-know-how-assurance-wireless-has-helped-you" target="_blank" style="position:relative;height:auto:width:auto;background-image:none;text-indent:0px;display:inline;top:0px;left:0px">Click here</a> to tell us your story.</p>
																<a href="http://newsroom.assurancewireless.com/webform/let-us-know-how-assurance-wireless-has-helped-you" target="_blank">// Learn More</a>
															</li>
															</xsl:when>
															
															<!-- PROGRAMS AND THE LATEST: THE LATEST: POSITION 2: EVERYTHIN ELSE  -->
															<xsl:otherwise>
																<xsl:comment>.</xsl:comment>
															</xsl:otherwise>
														</xsl:choose>
														<!-- END EVERYTHIN ELSE  -->
														
														<!-- PROGRAMS THE LATEST POSITION 3 -->
														<xsl:choose>
															
															<!-- PROGRAMS AND THE LATEST: THE LATEST: POSITION 3: PAYLO RD7  -->
															<xsl:when test="/vmu-page/login-session/voice-plan-cos = 'COS601' or /vmu-page/login-session/voice-plan-cos = 'COS602'">
																<li class="mouseout clickable">
																	<img src="${base_url_secure}/_img/myaccount/promos/international_170x90.jpg" width="170" height="90" alt="" />
																	<h3>Low International Rates</h3>
																	<p>Across the border or across the globe, with low rates to over 200 countries you can talk to loved ones all over the world.</p>
																	<a href="${base_url}/cell-phone-plans/international-phone-plans-rates?intcmp=c-pl-pl-pt1c-rd7intlrts-013112">// Learn More</a>
																</li>
																
																
																
															</xsl:when>
															<!-- END PAYLO RD7  -->
															
															<!-- PROGRAMS AND THE LATEST: THE LATEST: POSITION 3: PAYLO  -->
															<xsl:when test="$plan-type='paylo'">
																<!--<li class="mouseout clickable">
																	<img src="${base_url_secure}/_img/myaccount/promos/money-center_250x120.jpg" width="170" height="90" alt="" />
																	<h3>Money Center</h3>
																	<p>Recharge an international mobile phone,  pay bills or transfer money internationally...all from your phone</p>
																	<a href="http://virginmobileusa.custhelp.com/app/answers/detail/a_id/5741/kw/international%20money%20transfer?intcmp=c-pl-pt2a-moneyctr-031813">// Learn More</a>
																</li>-->
																<li class="mouseout clickable">
																	<img src="${base_url_secure}/_img/myaccount/promos/international_170x90.jpg" width="170" height="90" alt="" />
																	<h3>Low International Rates</h3>
																	<p>Across the border or across the globe: With low<br/>rates to over 200 countries, you can talk to loved<br/>ones all over the world.</p>
																	<a href="${base_url}/cell-phone-plans/international-phone-plans-rates?intid=CBM:BT:PL:PL:PT1C:130829:IntlRTS">// Learn More</a>
																</li>
															</xsl:when>
															<!-- END PAYLO  -->
															
															<!-- PROGRAMS AND THE LATEST: THE LATEST: POSITION 3: ALL BEYOND TALK  -->
															
															<xsl:when test="$plan-type='beyondtalk' or $plan-type='virginmobile'">
																<!--<li class="my_account_overlay clickable2 mouseout">
																	<img src="${base_url_secure}/_img/myaccount/promos/rpv_170x90.jpg" width="170" height="90" alt="" />
																	<h3>An Easier Way To Pay</h3>
																	<p>Register a credit/debit card or PayPal account and pay directly from your phone whenever you need more minutes.</p>
																	<a href="/myaccount/prepareCreditCardInformation.do">// Learn More</a>
																</li> -->
																
																<li class="mouseout clickable">
																	<img src="${base_url_secure}/_img/myaccount/promos/mingle_170x90.jpg" width="170" height="90" alt="" />
																	<h3>BE THE HOOK UP WITH MINGLE</h3>
																	<p>Be the hook up with Mingle&#8212;connect up to 10 Wi-Fi enabled devices. Plans start at $5/day. Nationwide Sprint® 4G LTE Network. No contract. </p>
																	<a href="${base_url}/shop/mobile-broadband/broadband-2-go/netgear-mingle/features/?intid=CBM:BT:PL:PT1C:141003:BB2G:Mingle">// Get It Now</a>
																</li>
																
																
																
																<!--<li class="mouseout clickable">
																	<img src="${base_url_secure}/_img/myaccount/promos/refer-friend-25_170x90.jpg" width="170" height="90" alt="" />
																	<h3>OUR FRIENDS GET BENEFITS</h3>
																	<p>Refer a Friend to Virgin Mobile and get hooked up with a $25 account credit. It pays to have friends.</p>
																	<a href="${base_url}/refer/?intid=AB:CBM:PYLO:PL:PT1C:140630:RAF:25AC:LM">// Learn More</a>
																</li>-->
																
															</xsl:when>
															<!-- END ALL BEYOND TALK  -->
															
															
															<!-- PROGRAMS AND THE LATEST: THE LATEST: POSITION 3: EVERYTHING ELSE  -->
															<xsl:otherwise>
																<xsl:comment>.</xsl:comment>
															</xsl:otherwise>
															<!-- END EVERYTHING ELSE  -->
														</xsl:choose>
													</ul>
													
												</div>						
												<div id="our_programs">
													
													<h2>Our Programs</h2>
													
													<ul>
														<xsl:choose>
															<xsl:when test="$plan-type='assurance'">
																<li class="mouseout clickable">
																	<h3 ><a style="color: #3a89bc;" href="${base_url}/cell-phone-plans/international-offers/#paylo?intid=CBM:BT:PL:PT2B:130829:IntlRTS">LIVE WITHOUT BORDERS
																	</a></h3>
																	<p>Virgin Mobile's new international offers let you stay connected with family and friends across the globe, because you shouldn't have to miss a thing no matter the distance.</p>
																</li>
																
																
																
															</xsl:when>
															<!-- PROGRAMS AND THE LATEST: OUR PROGRAMS: PAYLO RD7 -->
																<xsl:when test="/vmu-page/account-info/plan-info/@cos = 'COS601' or /vmu-page/account-info/plan-info/@cos = 'COS602'">
																		<!--<li class="mouseout clickable">
																		<h3><a href="${base_url}/virgin-mobile-life/cell-phone-kickbacks?intcmp=c-pl-pl-pt2a-rd7kickbk60min-013112">Earn Airtime With Kickbacks</a></h3>
																		<p>Earn 60 minutes for each friend who signs up with Virgin Mobile.</p>
																		</li>-->
																						
																		<!--<li class="mouseout clickable">
																		<h3><a href="${base_url}/virgin-mobile-life/recycle-cell-phone?intcmp=c-pl-pl-pt2b-rd7passon-013112">Pass It On</a></h3>
																		<p>Turn your old phone into free minutes. Don't throw it away, pass it on.</p>
																	</li>-->
																		
																		<li class="mouseout clickable">
																			<h3><a href="http://virginmobileusa.custhelp.com/app/answers/detail/a_id/938/kw/service%20preserver/session/L3RpbWUvMTMwMzE1OTY5Mi9zaWQvUWE0QUFQcms/?i?intcmp=c-pl-pt2c-rd7servpres-051512">One Year of Service</a></h3>
																			<p>Keep your service running for an entire year with a single Top-Up.</p>
																		</li>
																		<!--<li class="mouseout clickable">
																				<h3><a href="${base_url}/virgin-mobile-life/regeneration-past-about?intcmp=c-pl-pl-pt2c-rd7regen-013112">The RE*Generation</a></h3>
																				<p>Uniting our customers to help young people in need.</p>
																			</li>-->
																	</xsl:when>
																<!-- END PAYLO RD7 -->
																	
																<!-- PROGRAMS AND THE LATEST: OUR PROGRAMS: PAYLO -->
																<xsl:when test="$plan-type='paylo'">
																	<li class="mouseout clickable">
																		<h3><a href="http://virginmobileusa.custhelp.com/app/answers/detail/a_id/5741/kw/international%20money%20transfer?intid=CBM:PL:PL:PT2A:130829" target="_blank">MONEY CENTER</a></h3>
																		<p>Recharge an internatinal mobile phone,<br/>pay bills or transfer money internationaly...<br/>all from your phone.</p>
																	</li>
																	<li class="mouseout clickable">
																		<h3><a href="${base_url}/help-support/1yearofservice.html?intid=CBM:PL:PL:PT2B:130829:1YoS">SMOOTHER SERVICE</a></h3>
																		<p>Register your credit/debit card or PayPal account so you can keep talking without any interruptions.</p>
																	</li>
																	<li class="mouseout clickable">
																		<h3><a href="http://virginmobilefeed.com?intid=CBM:PL:PL:PT2C:130829:BRAND:VMF:COVMF" target="_blank">VIRGIN MOBILE FEED</a></h3>
																		<p>Find up-and-coming artists, must-see videos and the best of pop culture in one awesome place.</p>
																	</li>
																	
																	<!--<li class="mouseout clickable">
													<h3><a href="${base_url}/virgin-mobile-life/recycle-cell-phone?intcmp=c-pl-pl-pt2b-passon-013112">Pass It On</a></h3>
													<p>Turn your old phone into free minutes. Don't throw it away, pass it on.</p>
												</li>-->
																	
																	
																	<!--<li class="mouseout clickable">
													<h3><a href="http://virginmobileusa.custhelp.com/app/answers/detail/a_id/938/kw/service%20preserver/session/L3RpbWUvMTMwMzE1OTY5Mi9zaWQvUWE0QUFQcms/?i?intcmp=c-pl-pt2c-servpres-051512">One Year of Service</a></h3>
													<p>Keep your service running for an entire year with a single Top-Up.</p>
												</li>-->
																	
																	<!--<li class="mouseout clickable">
													<h3><a href="http://virginmobileusa.custhelp.com/app/answers/detail/a_id/5741/kw/international%20money%20transfer/?intcmp=c-pl-pt2a-IntlMoney-112012">International Money Transfer</a></h3>
													<p>Use your Virgin Mobile phone to transfer funds to friends and family around the world and stay connected anytime, anywhere.</p>
												</li>-->
																</xsl:when>
																<!-- END PAYLO -->
																
																<!-- PROGRAMS AND THE LATEST: OUR PROGRAMS: BEYOND TALK -->
																<xsl:when test="$plan-type='beyondtalk' or $plan-type='virginmobile'">
																	<li class="mouseout clickable">
																		<h3><a href="/myaccount/prepareCreditCardInformation.do?intid=CBM:BT:PL:PT2A:130829:RPV">KEEP YOUR SERVICE WORKING THE EASY WAY</a></h3>
																		<p>Register a credit/debit card or PayPal account and sign up for Auto Top-Up.</p>
																	</li>
																	<li class="mouseout clickable">
																		<h3><a href="https://buyback.virginmobileusa.com/vmb/?intid=CBM:BT:PL:PT2B:141003:BuyBack">GET THE GREEN YOU NEED FOR THE PHONE YOU WANT #BUYBACK</a></h3>
																		<p>You can earn up to $300 in account credit when you recycle your old phone with Virgin Mobile Buyback.</p>
																	</li>
																	
																	<!--<li class="mouseout clickable">
																		<h3><a href="${base_url}/virgin-mobile-life/cell-phone-kickbacks?intcmp=c-bt-pl-pt2a-kickbk60min-092811">Kickbacks</a></h3>
																		<p>Earn free minutes. Get 60 minutes for each friend you refer to Virgin Mobile.</p>
																	</li>-->
																	
																	<!--<li class="mouseout clickable">
																	<h3><a href="${base_url}/virgin-mobile-life/recycle-cell-phone?intcmp=c-bt-pl-pt2a-passon-013112">Pass It On</a></h3>
																	<p>Turn your old phone into free minutes. Don't throw it away, pass it on.</p> -->
																	<!-- <h3><a href="http://virginmobileusa.custhelp.com/app/answers/list/p/2488/c/0/search/1/kw/pay+now
">Keep Your Service Running Smoothly</a></h3>
																	<p>Instead of waiting until the end of your month, Pay Now so you don't risk interrupting your service.</p> -->
																					<!--</li>-->
																					<!-- <li class="mouseout clickable">
																	<h3><a href="http://virginmobilelive.com/?intcmp=c-pl-pt2a-vml-112012">Download the Virgin Mobile Live App</a></h3>
																	<p>Your personal guide to up-and-coming artists, must-see videos, and the best of today's mobile culture.</p> 
																</li>-->
																	<!--<li class="mouseout clickable">-->
																	<!--<h3><a href="http://www.facebook.com/VirginMobileLive" target="_blank">Virgin Mobile Live</a></h3>
																	<p>It's our 24/7 streaming music channel. It's live and it's FREE.
				Listen Now</p> -->
																					<!--<h3><a href="http://virginmobilelive.com/?intcmp=c-pl-pt1c-vml-051512">Download the Virgin Mobile Feed App</a></h3>
																	<p>Your personal guide to up-and-coming artists, must-see videos, and the best of today's mobile culture.</p> 
																</li>-->
																	
																</xsl:when>
																
																<!-- END BEYOND TALK -->
																
															</xsl:choose>
															<xsl:if test="$plan-type!='assurance'">
															<!-- All account see the refer a friend promo -->
															<li class="mouseout clickable">
																
																<h3><a href="${base_url}/refer/?intid=CBM:BT:PL:PT2C:131001:Refer:LM">OUR FRIENDS GET BENEFITS</a></h3>
																<!--<p>Refer a Friend to Virgin Mobile and get hooked up with a $25 account credit. It pays to have friends.</p>-->
																<p>Earn a $25 account credit for every friend you bring to Virgin Mobile, plus a one-time bonus $10 in PlayPhone<sup>&#174;</sup> PlayCredits<sup>&#8482;</sup>.</p>
															</li>
																
															<!-- END All account see the refer a friend promo -->
															</xsl:if>
													
														
													</ul>
													
												</div>					
												
												
											</div>
										</div>
									</div>
								</div>
							</div>
							
						</div>
					
						<div id="footer">
							<xsl:apply-templates mode="footer"/>
						</div>
					
					</div><!-- end maincontent --> 
				</div><!-- end Container -->
			</div><!-- end page wrapper -->
			<div id="xml" style="display:none">
				<xsl:comment>XML</xsl:comment>
				<xsl:copy-of select="."/>
			</div>

			<xsl:call-template name="s_code_secure"/>
			<xsl:text disable-output-escaping="yes">
    		<![CDATA[	
			<script type="text/javascript">
				$j(document).ready(function() {
					var entireMsgForTracking = trackingMsgMonthly +  trackingMsgOneTime;
					var pos = entireMsgForTracking.lastIndexOf('|');
					entireMsgForTracking = entireMsgForTracking.substring(0,pos);
					
					//console.log(entireMsgForTracking);
					//$j('.message-for-tracking-monthly').html(trackingMsgMonthly) ;
					//$j('.message-for-tracking-one-time').html(trackingMsgOneTime) ;


					if(tracking_code_status=="not done"){
						

						try{
							_$vmst("My Account-Prepaid: Account Summary Main Page",{prop57:"My Account-Prepaid: Account Summary Main Page",prop56:entireMsgForTracking,eVar62:entireMsgForTracking, events:"event58"});
						tracking_code_status="done";
						} 

							catch(err){;}
						};
				});

				</script>
			]]>
			</xsl:text>



			
			
			<!-- SECRET QUESTION POP-UP -->
			<xsl:if test="/vmu-page/account-info/secret-answer-expired = 'true'">
				<script>
					setActiveStyleSheet('plainwhite');
					$j.cookie('popover', 'true', {path: '/', domain: cookie_domain});
					$j(document).ready(function () {
						$j.fn.colorbox({width:"600px", inline:true, href:"#secret_question"});
					});
				</script>
				<div style="display:none">
					<div id="secret_question">
						<div class="box_container gray" id="secret_question_alert">
							<ul>
								<li class="icon"><img alt="caution" src="${base_url_secure}/_img/caution.png"/></li>
								<li class="copy">
									<h3>Important: You Need To Update Your Secret Question</h3>
									<p>We need you to provide an answer to a new security question. You will only have to provide the answer once and then it will serve as your new secret answer.  This is being done so that your account is more secure. Thanks!</p>
								</li>
							</ul>
						</div>
						<div class="split2" id="form_submit">
							<h5 class="btn btn_illdoitlater"><a onclick="$j.fn.colorbox.close(); return false;" href="javascript:void(0)">I'll Do It Later</a></h5>
							<h5 class="btn btn_updatemysecretquestion"><a><xsl:attribute name="class">my_account_overlay</xsl:attribute><xsl:attribute name="href"><xsl:value-of select="/vmu-page/account-info/security-setting-url"/></xsl:attribute>Update My Secret Question</a></h5>
						</div>
					</div>
				</div>
			</xsl:if>
			<!-- END SECRET QUESTION POP-UP -->
        
        <!-- PENDING PLAN CANCELLATION NOTICE -->
            <xsl:if test="normalize-space(/vmu-page/messages/message/key)='cancelAllPendingOrders.success'">
            	<script>
					$j(document).ready(function () {
						if(url_string.indexOf("?o=/myaccount") == -1){
							setActiveStyleSheet('plainwhite');
							$j.cookie('popover', 'true', {path: '/', domain: cookie_domain});
							$j.colorbox({width:"570px", height:"300px",inline:true, href:"#pending_cancel_success"});
						}
					});
				</script>
                <div style="display:none">
					<div id="pending_cancel_success">
						<h4 class="hdr">Success</h4>
						<p>Your order to switch plans was successfully cancelled.</p>
						<div class="alert alert-warning">
							<strong>IMPORTANT NOTE:</strong>
							It may take up to 15 minutes to see your changes reflected in My Sprint.
						</div>
						<p class="backlink">
							<a href="/myaccount/home.do" onclick="parent.$j.colorbox.close(); return false;" class="link" id="link_backtomyaccount">Back To My Sprint</a> 
						</p>
					</div>
					</div>
               
            </xsl:if>
			<xsl:if test="normalize-space(/vmu-page/messages/message/key)='cancelAllPendingOrders.error.VMU'">
				<script>
					$j(document).ready(function () {
					if(url_string.indexOf("?o=/myaccount") == -1){
					setActiveStyleSheet('plainwhite');
					$j.cookie('popover', 'true', {path: '/', domain: cookie_domain});
					$j.colorbox({width:"570px", height:"300px",inline:true, href:"#pending_cancel_success"});
					}
					});
				</script>
				<div style="display:none">
					<div id="pending_cancel_success">
						<div class="alert alert-icon">
							<h4><strong>Hold On</strong></h4>
							<p>Oops! There was a problem cancelling your pending migration. For assistance please call us at 1-888-322-1122.</p>
						</div>
						
						<p class="backlink">
							<a href="/myaccount/home.do" onclick="parent.$j.colorbox.close(); return false;" class="link" id="link_backtomyaccount">Back To My Sprint</a> 
						</p>
					</div>
				</div>
				
			</xsl:if>
       	<!-- END PENDING PLAN CANCELLATION NOTICE -->
        
		<!-- PHONE INSURANCE UPSELL OFFER -->
			<xsl:if test="/vmu-page/account-info/is-eligible-insurance-promo-popup = 'true'  and /vmu-page/account-info/secret-answer-expired = 'false'">
			<!-- want to supress the insurance offer pop-up if they're going to see the security question pop-up...don't want both to launch -->
				<script>
					$j(document).ready(function () {
						if(url_string.indexOf("?o=/myaccount") == -1){
							setActiveStyleSheet('plainwhite');
							$j.cookie('popover', 'true', {path: '/', domain: cookie_domain});
						  $j.fn.colorbox({width:"570px", inline:true, href:"#insurance_offer"});
						}
					});
				 </script>
				 <xsl:choose>
					<xsl:when test="normalize-space(/vmu-page/account-info/insurance/@type)='upfront' or normalize-space(/vmu-page/account-info/insurance/@type)='applecare+'">
						<div style="display:none">
							<div id="insurance_offer" style="padding:10px;font-size:12px">
								<h2 class="hdr" id="hdr_eligibleapplecare" style="height:40px">You're eligible for AppleCare+!</h2>
								<div style="float:left;padding:0px 20px 10px 0px">
									<img src="${base_url_secure}/_img/applecare_logo.png" alt="AppleCare+"/>
								</div>
								<p>You can still buy AppleCare+ through My Account within 24 hours of activation, or at an Apple Retail Store within 30 days of activation. Check this site to find an Apple Retail Store near you: <a href="http://www.apple.com/retail/storelist/">http://www.apple.com/retail/storelist/</a></p>
									
								<p>AppleCare+ includes coverage for up to two (2) incidents of accidental damage from handling, each subject to a $49 service fee.</p>
									
								<p>See terms at <a href="http://www.apple.com/legal/applecare/applecareplusforiphone.html" target="_blank">www.apple.com/legal/applecare/applecareplusforiphone.html</a> for full details.</p>
									
								<h5 class="btn btn_yessignmeup"><a href="/myaccount/prepareDeviceInsurance.do"><xsl:attribute name="class">my_account_overlay</xsl:attribute>Yes, Sign Me Up!</a></h5>
								<div style="clear:both">
									<a onclick="$j.fn.colorbox.close(); return false;" href="javascript:void(0)" style="display:block;font-size:11px;padding-top:5px;">No thanks.</a>
								</div>
							</div>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<div style="display:none">
							<div id="insurance_offer" style="padding:10px"><xsl:comment>stuff will go here</xsl:comment>
								<h2 class="hdr" id="hdr_eligiblephoneinsurance">You're eligible for phone insurance!</h2>
								<p>Nearly one in four people will experience loss, theft, or damage of their phone this year. Virgin Mobile Phone Insurance is the quickest, most affordable way to ensure you are never without your phone for long, providing a replacement service that covers loss, theft, damage, and out of warranty malfunction.</p>
								<p>For just $5/month, along with a deductible if you file a claim, you'll be covered if your Virgin Mobile device breaks or is lost, stolen, or damaged &#8212; even with liquid.</p>
								<h5 class="btn btn_yessignmeup"><a href="/myaccount/prepareDeviceInsurance.do"><xsl:attribute name="class">my_account_overlay</xsl:attribute>Yes, Sign Me Up!</a></h5>
								<div style="clear:both">
									<a onclick="$j.fn.colorbox.close(); return false;" href="javascript:void(0)" style="display:block;font-size:11px;padding-top:5px;">No thanks.</a>
								</div>
							</div>
						</div>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		<!-- END PHONE INSURANCE UPSELL OFFER -->
		
		<!-- APPLECARE+ UPSELL OFFER -->
			 <!--<xsl:if test="/vmu-page/account-info/is-eligible-insurance-promo-popup = 'true'">-->
			 <!-- if the insurance type is applecare, and the applecare flag is set to 'true' and the active flag is set to 'false', then show the applecare popup. -->
			 <xsl:if test="/vmu-page/account-info/insurance/@type='applecare+' and /vmu-page/account-info/insurance/@flag='true' and /vmu-page/account-info/insurance/active/@flag='false' and normalize-space(/vmu-page/account-info/needs-curing) != 'true' and normalize-space(/vmu-page/account-info/past-current) !='true'">
				<script>
					$j(document).ready(function () {
						  if(url_string.indexOf("?o=/myaccount") == -1){
							  setActiveStyleSheet('plainwhite');
							  $j.cookie('popover', 'true', {path: '/', domain: cookie_domain});
						  $j.fn.colorbox({width:"570px", inline:true, href:"#insurance_offer"});
						  }
					});
				</script>
				<div style="display:none">
					<div id="insurance_offer" style="padding:10px"><xsl:comment>stuff will go here</xsl:comment>
						<h2 class="hdr" id="hdr_eligiblephoneinsurance">You're eligible for AppleCare+!</h2>
						<p>You can still buy AppleCare+ through My Account within 24 hours of activation, or at an Apple Retail store within 30 days of activation. Check this site to find an Apple Retail store near you: <a href="http://www.apple.com/retail/storelist/">http://www.apple.com/retail/storelist/</a></p>
						<p>AppleCare+ includes coverage for up to two (2) incidents of accidental damage from handling, each subject to a $49 service fee.</p>
						<p>See terms at <a href="http://www.apple.com/legal/applecare/applecareplusforiphone.html" target="_blank">www.apple.com/legal/applecare/applecareplusforiphone.html</a> for full details.</p>
						<h5 class="btn btn_yessignmeup"><a href="/myaccount/prepareDeviceInsurance.do"><xsl:attribute name="class">my_account_overlay</xsl:attribute>Yes, Sign Me Up!</a></h5>
						<div style="clear:both">
							<a onclick="$j.fn.colorbox.close(); return false;" href="javascript:void(0)" style="display:block;font-size:11px;padding-top:5px;">No thanks.</a>
						</div>
					</div>
				</div>
			</xsl:if>
		<!-- END APPLECARE+ UPSELL OFFER -->
		<!-- RECURRING PHONE INSURANCE UPSELL OFFER -->
			<!-- I don't know if this flag is even still relevant-->
			<!--<xsl:if test="/vmu-page/account-info/is-eligible-insurance-promo-popup = 'true'">-->
			<xsl:if test="/vmu-page/account-info/insurance/@type='recurring' and /vmu-page/account-info/insurance/@flag='true' and /vmu-page/account-info/insurance/active/@flag='false'">
				<div style="display:none">
					<div id="insurance_offer" style="padding:10px"><xsl:comment>stuff will go here</xsl:comment>
					<h2 class="hdr" id="hdr_eligiblephoneinsurance">You're eligible for phone insurance!</h2>
						<p>Nearly one in four people will experience loss, theft, or damage of their phone this year. Virgin Mobile Phone Insurance is the quickest, most affordable way to ensure you are never without your phone for long, providing a replacement service that covers loss, theft, damage, and out of warranty malfunction.</p>
						<p>For just $5/month, along with a deductible if you file a claim, you'll be covered if your Virgin Mobile device breaks or is lost, stolen, or damaged &#8212; even with liquid.</p>
						<h5 class="my_account_overlay btn btn_yessignmeup"><a href="/myaccount/prepareDeviceInsurance.do">Yes, Sign Me Up!</a></h5>
						<div style="clear:both">
							<a onclick="$j.fn.colorbox.close(); return false;" href="javascript:void(0)" style="display:block;font-size:11px;padding-top:5px;">No thanks.</a>
						</div>
					</div>
				</div>
			</xsl:if>

        <!-- AW UPSELL OFFERS -->
        <!--<xsl:if test="/vmu-page/account-info/aw-bolt-on/is-eligible-aw-bolton-popup/eligible = 'true'">-->
			<xsl:if test="/vmu-page/account-info/is-eligible-aw-bolton-popup/eligible = 'true'">
				<xsl:for-each select="/vmu-page/account-info/aw-bolton-list-for-popup/aw-bolton-for-popup">
					<xsl:choose>
						<xsl:when test="position() = 1 and position() = last()">
							<script>
								$j(document).ready(function () {
									if(url_string.indexOf("?o=/myaccount") == -1){
										setActiveStyleSheet('plainwhite');
										$j.cookie('popover', 'true', {path: '/', domain: cookie_domain});
										$j.fn.colorbox({width:"545px", inline:true, href:"#awoffers"});
									}
								});
							</script>
						</xsl:when>
						<xsl:otherwise>
							<script>
								$j(document).ready(function () {
									if(url_string.indexOf("?o=/myaccount") == -1){
										setActiveStyleSheet('plainwhite');
										$j.cookie('popover', 'true', {path: '/', domain: cookie_domain});
										$j.fn.colorbox({width:"910px", inline:true, href:"#awoffers"});
									}
								});
							</script>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				<div style="display:none">
					<div id="awoffers">
						<ul id="aw_offer_list">
							<xsl:for-each select="/vmu-page/account-info/aw-bolton-list-for-popup/aw-bolton-for-popup">
								<xsl:variable name="offer" select="./@name"/>
								<li>
									<xsl:choose>
										<xsl:when test="position() = 1"><xsl:attribute name="class"><xsl:text>my_account_overlay offer1</xsl:text></xsl:attribute></xsl:when>
										<xsl:when test="position() = last()"><xsl:attribute name="class"><xsl:text>my_account_overlay offer</xsl:text></xsl:attribute></xsl:when>
									</xsl:choose>
									<xsl:if test="position() = 1 and position() = last()">
										<xsl:attribute name="style">border-right:1px solid #e4e4e4</xsl:attribute>
									</xsl:if>
									<xsl:choose>
										<xsl:when test="$offer = 'ASW20BOLT'">
											<div id="offer1000">
												this is the 1000 offer
										   </div>
										   <div class="aw_offer_button">
												<a style="" href="/myaccount/prepareAWBolton.do?promo=true&amp;awBolton=ASW20BOLT">Continue &amp; Close Window</a>
											</div>
										</xsl:when>
										<xsl:when test="$offer = 'ASW5BOLT'">
											<div id="offer500">
												This is the 500 offer
											</div>
											<div class="aw_offer_button">
												<a style="" href="/myaccount/prepareAWBolton.do?promo=true&amp;awBolton=ASW5BOLT">Continue &amp; Close Window</a>
											</div>
										</xsl:when>
									</xsl:choose>
								</li>
							</xsl:for-each>
						</ul>
						<div style="clear:both">
							<a onclick="$j.fn.colorbox.close(); return false;" href="javascript:void(0)" style="display:block;font-size:11px;padding-top:5px;">No thanks.</a>
						</div>
					</div>
				</div>
			</xsl:if>
		<!-- END AW UPSELL OFFERS -->
		
		


		
		<xsl:text disable-output-escaping="yes"> <![CDATA[<script type="text/javascript">_satellite.pageBottom();</script>]]> </xsl:text>
</body>
		</html>
	</xsl:template>
	
	
	<!-- ACCOUNT OVERVIEW: FOR YOUR PHONE -->
	<!-- ACCOUNT OVERVIEW: FOR YOUR PHONE -->
	<xsl:template name="featured-apps">
		<xsl:param name="phone-id" />
		<xsl:param name="display-mode" />
		
		<xsl:choose>
			<!-- ACCOUNT OVERVIEW: FOR YOUR PHONE: PAYLO -->
			<xsl:when test="$plan-type='paylo'">
				<ul>
					<xsl:if test="$display-mode = '2'">
						<xsl:attribute name="class">first</xsl:attribute>
					</xsl:if>
					<xsl:choose>
						<!-- ACCOUNT OVERVIEW: FOR YOUR PHONE: PAYLO REGULAR -->
						<xsl:when test="$plan-type='paylo'">
							<!--<li class="my_account_overlay mouseout"><img src="${base_url_secure}/_img/myaccount/apps/new_phone_box.jpg" alt="Got a New Phone?" />
          			<h3><a href="/myaccount/preparePhoneSwap.do?intcmp=c-pl-ao-pt1a-phoneswap-013112">Got a New Phone?</a></h3>
          			<p>Great, let us help you set it up. It only takes a few minutes.</p>
				</li>-->
							<li class="clickable mouseout"><img src="${base_url_secure}/_img/myaccount/apps/bb2go-overdrive.jpg" alt="4G On The Fly" />
								<h3><a href="${base_url}/shop/mobile-broadband/broadband-2-go/sierra-overdrive-pro/features/?intid=CBM:PL:AO:PT1A:130829:BB2G:GIN">4G On The Fly</a></h3>
								<p style="width:220px;">Connect your tablet, laptop, and other wireless devices. Wi-Fi, Whenever. Plans start at $5. Sprint&#174; 4G Network. No Contract.</p>
							</li>
							<!--<li class="clickable mouseout"><img src="${base_url_secure}/_img/myaccount/apps/paylo-40.jpg" alt="Got a New Phone?" />
          			<h3><a href="${base_url}/cell-phone-plans/paylo-plans/overview/">New! $40 Unlimited Talk &amp; Text</a></h3>
          			<p>Get Unlimited Minutes, Unlimited Messages, plus 50MB of Web Access for just $40 per month.</p>
         		</li>-->
							<li class="clickable mouseout"><img src="${base_url_secure}/_img/myaccount/apps/lost_phone.jpg" alt="Lost Your Phone?" />
								<h3><a href="/myaccount/lostPhone.do?intid=CBM:PL:AO:PT1B:120829:LostPhone">Lost Your Phone?</a></h3>
								<p>Don't panic. Let us know so we can secure your balance.</p>
							</li>
							<li class="clickable mouseout"><img src="${base_url_secure}/_img/myaccount/apps/international_rates.jpg" alt="Low International Rates" />
								<h3><a href="${base_url}/cell-phone-plans/international-phone-plans-rates?intid=CBM:BT:PL:AO:PT2B:130827:IntlRTS">Low International Rates</a></h3><p>Across the border or across the globe, with low rates to over 200 countries you can talk to loved ones all over the world.</p></li> 
						</xsl:when>
						<!-- ACCOUNT OVERVIEW: FOR YOUR PHONE: PAYLO RD7? -->
						<xsl:otherwise>
							<li class="clickable mouseout"><img src="${base_url_secure}/_img/myaccount/apps/international_rates.jpg" alt="Low International Rates" />
								<h3><a href="${base_url}/cell-phone-plans/international-phone-plans-rates?intcmp=c-pl-ao-pt1a-rd7intlrts-013112">Low International Rates</a></h3><p>Across the border or across the globe, with low rates to over 200 countries you can talk to loved ones all over the world.</p></li> 
							<li class="my_account_overlay mouseout"><img src="${base_url_secure}/_img/myaccount/apps/new_phone_box.jpg" alt="Got a New Phone?" />
								<h3><a href="/myaccount/preparePhoneSwap.do?intcmp=c-pl-ao-pt1b-rd7phoneswap-013112">Got a New Phone?</a></h3>
								<p>Great, let us help you set it up. It only takes a few minutes.</p>
							</li>
							<li class="clickable mouseout"><img src="${base_url_secure}/_img/myaccount/apps/lost_phone.jpg" alt="Lost Your Phone" />
								<h3><a href="/myaccount/lostPhone.do?intcmp=c-pl-ao-pt1c-rd7lostphone-013112">Lost Your Phone?</a></h3>
								<p>Don't panic. Let us know so we can secure your balance.</p>
								
							</li>
						</xsl:otherwise>
					</xsl:choose>
				</ul>
			</xsl:when>
			<!-- ACCOUNT OVERVIEW: FOR YOUR PHONE: BEYOND TALK -->
			<xsl:otherwise>
				<ul>
					<xsl:if test="$display-mode = '2'">
						<xsl:attribute name="class">first</xsl:attribute>
					</xsl:if>

					<li class="clickable mouseout"><img src="${base_url_secure}/_img/myaccount/apps/pay_now.jpg" alt="An Easy Way to Keep Talking"/><h3><a href="/myaccount/home.do?o=/myaccount/prepareAdvancePayment.do?intid=CBM:BT:AO:PT1C:130829:PayNow">An Easy Way to Keep Talking</a></h3><p>Keep your service running smoothly with Pay Now. Pay for your next month of service  today.</p>
					</li> 
					
					<li class="clickable mouseout"><img src="${base_url_secure}/_img/myaccount/apps/lost_phone.jpg" alt="Lost Your Phone?"/><h3><a href="/myaccount/lostPhone.do?intid=CBM:BT:AO:PT1B:120829:LostPhone">Lost Your Phone?</a></h3><p>Don't panic. Let us know so we can secure your balance.</p></li>
					
					<li class="clickable mouseout"><img src="${base_url_secure}/_img/myaccount/apps/rpv.jpg" alt="Register a credit debit or PayPal account and sign up for Auto Top-Up" /><h3><a href="/myaccount/prepareCreditCardInformation.do?intid=CBM:BT:AO:PT1A:130829:RPV">KEEP YOUR SERVICE WORKING THE EASY WAY</a></h3><p>Register a credit/debit card or PayPal account and sign up for Auto Top-Up.</p></li> 	
					
				</ul>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="featured-apps2">
		<xsl:param name="phone-id" />
		<xsl:param name="display-mode" />
		
		<xsl:choose>
			<!-- PHONE, APPS AND MORE: FOR YOUR PHONE: PAYLO -->
			<xsl:when test="$plan-type='paylo'">
				<ul>
					<xsl:if test="$display-mode = '2'">
						<xsl:attribute name="class">first</xsl:attribute>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="$plan-cos='COS401' or $plan-cos='COS402' or $plan-cos='COS403' or $plan-cos='COS404' or $plan-cos='COS405'">
							
							<li class="clickable mouseout"><img src="${base_url_secure}/_img/myaccount/apps/lost_phone.jpg" alt="Lost Your Phone?" />
								<h3><a href="/myaccount/lostPhone.do?intid=CBM:PL:PAM:PT1A:120829:LostPhone">Lost Your Phone?</a></h3>
								<p>Don't panic. Let us know so we can secure your balance.</p>
							</li>
							
							<li class="clickable mouseout"><img src="${base_url_secure}/_img/myaccount/apps/rpv.jpg" alt="KEEP YOUR SERVICE WORKING THE EASY WAY"/><h3><a href="/myaccount/prepareCreditCardInformation.do?intid=CBM:PL:PAM:PT2:130829:RPV">KEEP YOUR SERVICE WORKING THE EASY WAY</a></h3><p>Register a credit/debit card or PayPal account and sign up for Auto Top-Up.</p>
							</li>
							
							<li class="clickable mouseout"><img src="${base_url_secure}/_img/myaccount/apps/international_rates.jpg" alt="Low International Rates" />
								<h3><a href="${base_url}/cell-phone-plans/international-phone-plans-rates?intid=CBM:BT:PL:PAM:PT3:130829:IntlRTS">Low International Rates</a></h3><p>Across the border or across the globe:<br/>With low rates to over 200 countries, you<br/>can talk to loved ones all over the world.</p></li>
							
							<li class="clickable mouseout"><img src="${base_url_secure}/_img/myaccount/apps/money-center.jpg" alt="MONEY CENTER"/><h3><a href="http://virginmobileusa.custhelp.com/app/answers/detail/a_id/5741/kw/international%20money%20transfer?intid=CBM:PL:PAM:PT3B:130829" target="_blank">MONEY CENTER</a></h3><p>Recharge an international mobile phone, pay bills or transfer money internationally... all from your phone.</p></li>				
							
							<li class="clickable mouseout"><img src="${base_url_secure}/_img/myaccount/apps/vm-feed.jpg" alt="Virgin Mobile Feed"/><h3 style="width:170px;"><a href="http://virginmobilefeed.com?intid=CBM:PL:PAM:PT3C:130829:BRAND:VMF:COVMF" target="_blank">VIRGIN MOBILE FEED</a></h3><p>Find up-and-coming artists, must-see<br/>videos and the best of pop culture in one<br/>awesome place.</p>
							</li>
							
							<li style="background:none;">&nbsp;</li>
							
						</xsl:when>
						<xsl:otherwise>
							<li class="clickable mouseout"><img src="${base_url_secure}/_img/myaccount/apps/lost_phone.jpg" alt="Lost Your Phone?" />
								<h3><a href="/myaccount/lostPhone.do?intcmp=c-pl-pt1-rd7lostphone-051512">Lost Your Phone?</a></h3>
								<p>Don't panic. Let us know so we can secure your balance.</p>
							</li>
							<li class="clickable mouseout"><img src="${base_url_secure}/_img/myaccount/apps/rpv.jpg" alt="Smoother Service" />
								<h3><a href="/myaccount/prepareCreditCardInformation.do?intcmp=c-pl-pt2-rd7rpv-051512">Smoother Service</a></h3>
								<p>Register your credit/debit card or PayPal account so you can keep talking without any interruptions.</p>
							</li>
							<li style="background:none;">&nbsp;</li>
						</xsl:otherwise>
					</xsl:choose>
				</ul>
			</xsl:when>
			<!-- PHONE, APPS AND MORE: FOR YOUR PHONE: BEYOND TALK -->
			<xsl:otherwise>
				<ul>
					<xsl:if test="$display-mode = '2'">
						<xsl:attribute name="class">first</xsl:attribute>
					</xsl:if>
					
					<li class="clickable mouseout"><img src="${base_url_secure}/_img/myaccount/apps/vmextras.jpg" alt="Virgin Mobile Extras" />
						<h3><a href="${base_url}/extras">Virgin Mobile Extras</a></h3>
						<p>Virgin Mobile gives you extra...from international calling options, to mobile hotspots, games, music and more. Check it out here. </p>
					</li>
					
				</ul>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="display-balance-info">

	<xsl:variable name="total-amount-due">
		<xsl:choose>
			<xsl:when test="contains(/vmu-page/account-info/plan-info/is-ro-plan,'true')">
				<xsl:value-of select="/vmu-page/account-info/next-payment-due/total" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/vmu-page/account-info/plan-info/total" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="display-state">
		<!-- 
			1 = RO, No RPV, Normal - no advance payment, gets purple message, balance_info3b, balance is LESS THAN the plan cost, 4 boxes
			
			18 = RO, No RPV, Normal -  made advance payment, gets green message, balance_info1b, balance is LESS THAN the plan cost but we don't care since they paid for next month's plan, 3 boxes
			 
			2 = RO, No RPV, Due in 3 Days - no advance payment, gets purple message, balance_info5b, balance is GREATER THAN the plan cost
			21 = RO, No RPV, Due in 3 Days - no advance payment, gets purple message, balance_info2b, balance is LESS THAN plan cost, 4 boxes
			
			3 = RO, No RPV, Past Due - no advance payment, gets purple message, balance_info6b, balance is GREATER THAN the plan cost - I don't know if this would ever apply
			
			31 = RO, No RPV, Past Due - no advance payment, gets red message, balance_info4b, balance is LESS THAN plan cost, 4 boxes
			
			17 = RO, No RPV, no advance payment, Balance is GREATER THAN the plan cost, gets purple message, balance_info5b
			
			19 = RO, No RPV, made advance payment, Balance is GREATER THAN the amount due -  gets green message, balance_info1b
			
			These paygo numbers will only apply to COS402 since I placed the other month plans in with the other RO plans
			4 = PAYGO, No RPV, Normal - balance_info1.gif
			5 = PAYGO, No RPV, Due in 3 days - balance_info5.gif ????
			6 = PAYGO, No RPV, Past Due - balance_info6.gif

			7 = RO, With RPV - no advance payment, gets purple message, balance_info5b
			
			20 = RO, With RPV -  made advance payment, gets green message, balance_info1b
			
			8 = RO, With RPV, Due in 3 Days - no advance payment, gets purple message, balance_info5b
			
			9 = RO, With RPV, Past Due - no advance payment, gets purple message, balance_info6b
			
			10 = PAYGO, With RPV, Normal - balance_info1.gif
			11 = PAYGO, With RPV, Due in 3 days - balance_info5.gif ????
			12 = PAYGO, With RPV, Past Due - balance_info6.gif
			
			13 = Assurance Wireless ONLY 807 or 211. It seems that all other AW PLANS will be considered RO's.
			
			14 = Assurance Wireless COS805 info6
			
		   15 = Assurance Wireless COS805 in case it's ever a normal COS
			
			16 = Assurance Wireless COS805, but has a pending migration to a plan
			
		-->
		<xsl:choose>
			<!-- Assurance Wireless Free plans -->
			<xsl:when test="$plan-cos = 'COS211' or $plan-cos = 'COS807' or $plan-cos = 'COS809' or $plan-cos = 'COS815' or $plan-cos = 'COS816'">13</xsl:when>
			<!-- Assurance wireless holding COS -->
			<xsl:when test="$plan-cos = 'COS805'">
				<xsl:choose>
					<xsl:when test="/vmu-page/account-info/plan-info/iscustomer-in-skininthegame-onlandingcos = 'true'">
						<xsl:choose>
							<xsl:when test="/vmu-page/account-info/pending-plan-migration/@status = 'true'">16</xsl:when>
							<xsl:otherwise>14</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>15</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- RO Plan, including payLo monthly plans and AW monthly plans COS802, COS803, COS806, COS804-->
			<xsl:when test="(contains(/vmu-page/account-info/plan-info/is-ro-plan,'true') or $paylo-monthly='true')">
				<xsl:choose>
					<!-- Has RPV -->
					<xsl:when test="/vmu-page/account-info/payment-method/cheque-flag = 'true' or /vmu-page/account-info/payment-method/paypal-flag = 'true' or /vmu-page/account-info/payment-method/cc-flag = 'true'">
						<xsl:choose>
							<xsl:when test="contains(/vmu-page/account-info/is-advance-payment-exist,'true')">20</xsl:when>
							
							<xsl:when test="/vmu-page/account-info/next-payment-due/days-left = '3'">8</xsl:when>
							
							<xsl:when test="/vmu-page/account-info/past-current = 'true'">9</xsl:when>
							
							<!-- change below from a 7 to whatever you want to see -->
							<xsl:otherwise>7</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!-- No RPV -->
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="/vmu-page/account-info/next-payment-due/days-left = '3'">
								<xsl:choose>
									<xsl:when test="$balance_is_greater_than_plancost='true'">2</xsl:when>
									<xsl:otherwise>21</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="contains(/vmu-page/account-info/past-current,'true')">
								<xsl:choose>
									<xsl:when test="$balance_is_greater_than_plancost='true'">3</xsl:when>
									<xsl:otherwise>31</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<!-- balance IS GREATER THAN the plan cost -->
									<xsl:when test="$balance_is_greater_than_plancost='true'">
										<xsl:choose>
											<xsl:when test="contains(/vmu-page/account-info/is-advance-payment-exist, 'true')">19</xsl:when>
											<xsl:otherwise>17</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<!-- balance IS LESS THAN the plan cost -->
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="contains(/vmu-page/account-info/is-advance-payment-exist, 'true')">18</xsl:when>
											<xsl:otherwise>1</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- PAYGO Plan COS402, COS199-->
			<xsl:otherwise>
				<xsl:if test="$plan-cos = 'COS402' or $plan-cos = 'COS405' or $plan-cos = 'COS199' or $plan-cos = 'COS41' or $plan-cos = 'COS42' or $plan-cos = 'COS20'">1-</xsl:if>
				
				<xsl:choose>
					<!-- Has RPV -->
					<!-- 10 = a current account -->
					<!-- 11 = an account that's has 3 days left until the due date -->
					<!-- 12 = an account that's past the due date (past current) -->
					<xsl:when test="/vmu-page/account-info/payment-method/cheque-flag = 'true' or /vmu-page/account-info/payment-method/paypal-flag = 'true' or /vmu-page/account-info/payment-method/cc-flag = 'true'">
						<xsl:choose>
							<xsl:when test="/vmu-page/account-info/next-payment-due/days-left = '3'">11</xsl:when>
							<xsl:when test="/vmu-page/account-info/past-current = 'true'">12</xsl:when>
							<xsl:otherwise>10</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!-- No RPV -->
					<!-- 4 = a current account -->
					<!-- 5 = an account that's has 3 days left until the due date -->
					<!-- 6 = an account that's past the due date (past current) -->
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="/vmu-page/account-info/next-payment-due/days-left = '3'">5</xsl:when>
							<xsl:when test="/vmu-page/account-info/past-current = 'true'">6</xsl:when>
							<xsl:otherwise>4</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<div class="row">
		<div class="col-md-12">
			<xsl:attribute name="id">
				<xsl:choose>
					<!-- 1 = RO, No RPV, Normal - no advance payment, gets purple message, balance_info3b, balance is LESS THAN the plan cost, covers all monthly recurring charge plans, even assurance -->
					<xsl:when test="$display-state = '1'">balance_info3b</xsl:when>
					
					<!-- 18 = RO, No RPV, Normal -  made advance payment, gets green message, balance_info1b, balance is LESS THAN the plan cost but we don't care since they paid for next month's plan, 3 boxes -->
					<xsl:when test="$display-state = '18'">balance_info1b</xsl:when>
				   
					<!-- 2 = RO, No RPV Due in 3 days, no advance payment, gets purple message, balance_info5b, balance is GREATER THAN plan cost, covers all monthly recurring charge plans, even assurance -->
					<xsl:when test="$display-state = '2'">balance_info5b</xsl:when>
					
					<!-- 21 = RO, No RPV, Due in 3 Days - no advance payment, gets purple message, balance_info2b, balance is LESS THAN plan cost -->
					<xsl:when test="$display-state = '21'">balance_info2b</xsl:when>
					
					<!-- 3 = RO, No RPV, Past Due - no advance payment, gets purple message, balance_info6b, balance is GREATER THAN plan cost -->
					<xsl:when test="$display-state = '3'">balance_info6b</xsl:when>
					
					<!-- 31 = RO, No RPV, Past Due - no advance payment, gets purple (red?) message, balance_info4b, balance is LESS THAN plan cost -->
					<xsl:when test="$display-state = '31'">balance_info4b</xsl:when>
					
					<!-- 8 = RO, RPV, no advance payment, due in 3 days gets purple message, balance_info5b -->
					<xsl:when test="$display-state = '8'">balance_info5b</xsl:when>
					
					<!-- 17 = RO, No RPV, no advance payment, Balance is GREATER THAN the plan cost, gets purple message, balance_info5b -->
					<xsl:when test="$display-state = '17'">balance_info5b</xsl:when>
					
					<!-- 19 = RO, No RPV, made advance payment, Balance is GREATER THAN the amount due -  gets green message, balance_info1b -->
					<xsl:when test="$display-state = '19'">balance_info1b</xsl:when>
					
					<!-- 7 = RO, With RPV - no advance payment, gets purple message, balance_info5b -->
					<xsl:when test="$display-state = '7'">balance_info5b</xsl:when>
					
					<!-- 20 = RO, With RPV -  made advance payment, gets green message, balance_info1b -->
					<xsl:when test="$display-state = '20'">balance_info1b</xsl:when>
				  
					<!-- 4 = PAYGO, No RPV, Normal and 10 = PAYGO, With RPV, Normal, this should only before COS402 and COS199 -->
					<xsl:when test="$display-state = '4' or $display-state = '10'">balance_info1</xsl:when>
					
					<xsl:when test="$display-state = '1-4' or $display-state = '1-10'">balance_info1d</xsl:when>
					
					<!-- 5 = PAYGO, No RPV, Due in 3 days and 11 = PAYGO, With RPV, Due in 3 days -->
					<xsl:when test="$display-state = '5' or $display-state = '11'">balance_info5</xsl:when>
					
					<xsl:when test="$display-state = '1-5' or $display-state = '1-11'">balance_info5d</xsl:when>
					
					<!-- 12 = PAYGO, With RPV, Past Due and 14 = Assurance Wireless COS805 (holding COS -->
					<xsl:when test="$display-state = '6' or $display-state = '12' or $display-state = '14'">balance_info6</xsl:when>

					<xsl:when test="$display-state = '1-6' or $display-state = '1-12'">balance_info6d</xsl:when>

					<!-- 9 = RO, With RPV, Past Due -->
					<xsl:when test="$display-state = '9'">balance_info6b</xsl:when>
				  
					<xsl:when test="$display-state = '13'">balance_info1c</xsl:when> <!-- 13 = Assurance Wireless ONLY 807 or 211. It seems that all other AW PLANS will be considered RO's. -->
					
					<xsl:when test="$display-state = '15'">balance_info1</xsl:when> <!-- 15 = Assurance Wireless COS805 in case it's ever a normal COS -->
					
					<xsl:when test="$display-state = '16'">balance_info1</xsl:when> <!-- Assurance Wireless COS805, but has a pending migration to a plan -->
				</xsl:choose>
			</xsl:attribute>
	
			<h2 id="hdl_balanceinfo" class="hdl_page_title">Balance Info</h2>
			
			<xsl:choose>
				<xsl:when test="$mrc-warning-to-320-autopay='true'">
					<div class="alert alert-warning" style="background-image:none;padding:10px 10px;text-align:center">
						<p style="font-size:12px;margin-bottom:0px;">The $5 Auto Pay discount for iPhone is not applicable for the $20 plan.</p>
						
						<p style="font-size:12px;font-size:12px;margin-bottom:0px;">*Your Next Month's Charge amount is $20. The correct amount will be charged at the time your Monthly Charge is due.</p>
					</div>
				</xsl:when>
				<xsl:when test="$mrc-warning-to-or-on-320-noautopay='true'">
					<div class="alert alert-warning" style="background-image:none;padding:10px 10px;text-align:center">
						<p style="font-size:12px;margin-bottom:0px;">The $5 Auto Pay discount for iPhone is not applicable for the $20 plan.</p>
						
						
					</div>
				</xsl:when>
				<xsl:when test="$mrc-discount='eligible' or $mrc-warning-from-320='true'">
					<xsl:call-template name="mrc-discount-promos">
						<xsl:with-param name="context">myaccount-ao</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				
				
				<xsl:when test="$plan-type='assurance'">
					<div style="margin:10px 0px">
						<a href="http://newsroom.assurancewireless.com/webform/let-us-know-how-assurance-wireless-has-helped-you" target="blank"><img src="${base_url_secure}/_img/myaccount/aw-testimonials.png"/></a>
					</div>
					
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="$plan-type='virginmobile' or $plan-type='beyondtalk'">
					<div style="margin:10px 0px">
						<a href="${base_url}/cell-phone-plans/international-phone-plans-rates/" target="blank"><img src="${base_url_secure}/_img/myaccount/promos/international_banner.jpg"/></a>
					</div>
					</xsl:if>
					
				</xsl:otherwise>
			</xsl:choose>
			<div>
				<xsl:if test="$display-state!='1-4' and $display-state!='1-5' and $display-state!='1-11' and $display-state!='1-10'">
					<xsl:attribute name="class">well-dark-gray</xsl:attribute>
				</xsl:if>
				<xsl:if test="$display-state = '1' or $display-state = '18' or $display-state = '2' or $display-state = '21' or $display-state = '3' or $display-state = '31' or $display-state = '17' or $display-state = '19' or $display-state = '7' or $display-state = '20' or $display-state = '6' or $display-state = '1-6' or $display-state = '9' or $display-state = '12'  or $display-state = '1-12' or $display-state = '5' or $display-state = '8' or $display-state = '11' or $display-state = '14'">
					
				<!-- Now everyone should see the notice except paygo people, and maybe COS807 and COS211 -->
					<div id="notice">
						<xsl:choose>
							<!-- Assurance COS805 -->
							<xsl:when test="$display-state = '14'">
								<h3><strong>You must choose a plan by <xsl:value-of select="/vmu-page/account-info/plan-info/@expires"/> to start your Assurance Wireless service.</strong></h3>
							</xsl:when>
							<!-- These are the states where the due date is farther than 3 days away and the user has made an advance payment, user DOES NOT have an RPV-->
							<xsl:when test="$display-state = '18' or $display-state = '19' or $display-state = '20'">
								<h3><strong>You have paid for next month's plan starting on <xsl:value-of select="/vmu-page/login-session/ctd-plus-1"/></strong>&#160;&#160;&#160;<a class="my_account_overlay" href="/myaccount/cancelAdvancePayment.do">Cancel My Payment</a></h3>
							</xsl:when>
							<!-- These are the states where the due date is 3 days or more away and the user has NOT made an advance payment and they do not have an RPV registered, and they may not have enough in their cash balance to cover the cost of the plan, so we may have to show a calculation-->
							<xsl:when test="$display-state = '1' or $display-state = '2' or $display-state = '21' or $display-state = '17'">
								<h3>
									<xsl:choose>
										<xsl:when test="/vmu-page/account-info/advance-payment/@enabled='true'">
											<strong>Pay Now for Next Month's Plan</strong>&#160;&#160;
												<xsl:choose>
													<xsl:when test="$balance_is_greater_than_plancost = 'false'">
														(Add at least $<xsl:value-of select="$positive_difference_owed"/> +tax to pay for next month's plan.)
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="normalize-space(/vmu-page/account-info/needs-curing)='true' or normalize-space(/vmu-page/account-info/past-current)='true'">
																(<xsl:value-of select="/vmu-page/account-info/next-payment-due/total" /> + tax due NOW)
															</xsl:when>
															<xsl:otherwise>
																(
																<xsl:choose>
																	<xsl:when test="$plan-type='paylo'">
																		<xsl:value-of select="/vmu-page/account-info/plan-info/total"/>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:value-of select="/vmu-page/account-info/next-payment-due/total"/>
																	</xsl:otherwise>
																</xsl:choose>
																+ tax due on <xsl:value-of select="/vmu-page/account-info/next-payment-due/topup-by-date"/>)
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
										<xsl:otherwise>
											<strong>Payment of 
												<xsl:choose>
													<xsl:when test="$paylo-monthly='true'">
														<xsl:value-of select="/vmu-page/account-info/plan-info/total" />
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="/vmu-page/account-info/next-payment-due/total" />
													</xsl:otherwise>
												</xsl:choose> +tax due&#160;
												<xsl:choose>
													<xsl:when test="normalize-space(/vmu-page/account-info/needs-curing)='true' or normalize-space(/vmu-page/account-info/past-current)='true'">NOW</xsl:when>
													<xsl:otherwise>on <xsl:value-of select="/vmu-page/account-info/next-payment-due/topup-by-date"/></xsl:otherwise>
												</xsl:choose>
											</strong>&#160;&#160;
											<!-- show the outstanding amount if the cash balance is less than the amount owed -->
											<xsl:if test="$balance_is_greater_than_plancost = 'false'">
												(Add at least $<xsl:value-of select="$positive_difference_owed"/> +tax to pay for next month's plan.)
											</xsl:if>
											<!-- end show the outstanding amount if the cash balance is less than the amount owed -->
										</xsl:otherwise>
									</xsl:choose>
								</h3>
							</xsl:when>	
							<!-- These accounts have not made an advance payment, have an RPV registered-->
							<xsl:when test="$display-state = '7' or $display-state = '8'">
								<h3>
									<strong>Pay Now for Next Month's Plan</strong>&#160;&#160;
									(<xsl:choose>
										<xsl:when test="$paylo-monthly='true'">
											<xsl:value-of select="/vmu-page/account-info/plan-info/total" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="/vmu-page/account-info/next-payment-due/total" />
										</xsl:otherwise>
									</xsl:choose> +tax due on <xsl:value-of select="/vmu-page/account-info/next-payment-due/topup-by-date"/>)
								</h3>
							</xsl:when>			
							<!-- These accounts are past due and see the red message with an expandable explanation -->
							<xsl:when test="$display-state = '3' or $display-state = '31' or $display-state = '6' or $display-state = '1-6' or $display-state = '9' or $display-state = '12' or $display-state = '1-12'">
								<div class="panel-group" id="accordion">
									<div class="panel panel-default">
										<div class="panel-heading">
											<div class="row">
												<div class="col-md-10">
													<h3>
														<strong>Your account is past due</strong> You won't be able to use your phone until you Top-Up your account)
													</h3>
												</div>
												<div class="col-md-2">
													<a id="a-expand" class="accordion-toggle" onclick="$j('#a-collapse').toggle();$j('#a-expand').toggle()" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
															view full details <span style="padding:0px;margin:0px;font-size:12px">+</span></a>
													<a id="a-collapse" style="display:none" onclick="$j('#a-collapse').toggle();$j('#a-expand').toggle()" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
													hide full details <span style="padding:0px;margin:0px;font-size:12px">-</span></a>
												</div>
											</div>
										</div>
										<div id="collapseOne" class="panel-collapse collapse">
											<div class="panel-body">
												<ul>
													<li>Please add enough money to cover the cost of your monthly charge (plus taxes and surcharges).</li>
													<li>If you're paying with Top-Up cards, make sure you have enough money in your balance to cover the cost of the monthly charge (plus taxes &amp; surcharges) each month.</li>
												</ul>
											</div>
										</div>
									</div>
								</div>
							</xsl:when>
						</xsl:choose>
					</div>
				
				</xsl:if>
					
				<!--<span style="font-size:14px">DISPLAY STATE IS: <xsl:value-of select="$display-state"/></span><br/>-->
				<div class="well-gray-gradient">
					<div class="row details">
						<div class="col-md-12">
							
								<div id="module1" class="info-module">
									<h3>
										<xsl:choose>
											<xsl:when test="$display-state = '1'">Next Month's Charge</xsl:when>
											<xsl:when test="$display-state = '2'">Next Month's Charge</xsl:when>
											<xsl:when test="$display-state = '21'">Next Month's Charge</xsl:when>
											<xsl:when test="$display-state = '3'">Next Month's Charge</xsl:when>
											<xsl:when test="$display-state = '31'">Next Month's Charge</xsl:when>
											<xsl:when test="$display-state = '4' or $display-state = '1-4'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '5' or $display-state = '1-5'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '6' or $display-state = '1-6'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '7'">Next Month's Charge</xsl:when>
											<xsl:when test="$display-state = '8'">Next Month's Charge</xsl:when>
											<xsl:when test="$display-state = '9'">Next Month's Charge</xsl:when>
											<xsl:when test="$display-state = '10' or $display-state = '1-10'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '11' or $display-state = '1-11'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '12' or $display-state = '1-12'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '13'">Next Month's Charge</xsl:when>
											<xsl:when test="$display-state = '14'">Next Month's Charge</xsl:when>
											<xsl:when test="$display-state = '15'">Next Month's Charge</xsl:when>
											<xsl:when test="$display-state = '16'">Next Month's Charge</xsl:when>
											<xsl:when test="$display-state = '17'">Next Month's Charge</xsl:when>
											<xsl:when test="$display-state = '18'">Monthly Charge</xsl:when>
											<xsl:when test="$display-state = '19'">Monthly Charge</xsl:when>
											<xsl:when test="$display-state = '20'">Monthly Charge</xsl:when>
										</xsl:choose>
									</h3>
									
									<p>
										<xsl:choose>
											<xsl:when test="$display-state = '1' or $display-state = '21' or $display-state = '31'">
												<xsl:choose>
													<xsl:when test="$paylo-monthly='true'">
														<xsl:value-of select="/vmu-page/account-info/plan-info/total" />
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="/vmu-page/account-info/next-payment-due/total" />
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:when test="$display-state = '18'"><xsl:value-of select="$total-amount-due" /></xsl:when>
											<xsl:when test="$display-state = '2'"><xsl:value-of select="$total-amount-due" /></xsl:when>
											<xsl:when test="$display-state = '3'"><xsl:value-of select="$total-amount-due" /></xsl:when>
											<xsl:when test="$display-state = '4' or $display-state = '1-4'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '5' or $display-state = '1-5'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '6' or $display-state = '1-6'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '7'"><xsl:value-of select="$total-amount-due" /></xsl:when>
											<xsl:when test="$display-state = '17'"><xsl:value-of select="$total-amount-due" /></xsl:when>
											<xsl:when test="$display-state = '19'"><xsl:value-of select="$total-amount-due" /></xsl:when>
											<xsl:when test="$display-state = '20'"><xsl:value-of select="$total-amount-due" /></xsl:when>
											<xsl:when test="$display-state = '8'"><xsl:value-of select="$total-amount-due" /></xsl:when>
											<xsl:when test="$display-state = '9'"><xsl:value-of select="$total-amount-due" /></xsl:when>
											<xsl:when test="$display-state = '10' or $display-state = '1-10'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '11' or $display-state = '1-11'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '12' or $display-state = '1-12'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '13'">
												<xsl:choose>
													<xsl:when test="/vmu-page/account-info/next-payment-due/@status='true'"><xsl:value-of select="$total-amount-due" /></xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="/vmu-page/account-info/aw-bolt-on/@flag = 'true'">
																<xsl:choose>
																	<xsl:when test="contains(/vmu-page/account-info/aw-bolt-on/active-bolt-on/name,'ASW5BOLT')">$5</xsl:when> 
																	<xsl:when test="contains(/vmu-page/account-info/aw-bolt-on/active-bolt-on/name,'ASW20BOLT')">$20</xsl:when>
																	<xsl:when test="contains(/vmu-page/account-info/aw-bolt-on/active-bolt-on/name,'AWMISM250')">$5</xsl:when> 
																	<xsl:when test="contains(/vmu-page/account-info/aw-bolt-on/active-bolt-on/name,'AWMISM750')">$20</xsl:when> 
																	<xsl:when test="contains(/vmu-page/account-info/aw-bolt-on/active-bolt-on/name,'AWMISM750')">$20</xsl:when> 
																	<xsl:when test="contains(/vmu-page/account-info/aw-bolt-on/active-bolt-on/name,'AWMISDUNL') or contains(/vmu-page/account-info/aw-bolt-on/active-bolt-on/name,'ASW30BOLT')">$30</xsl:when>
																	<xsl:otherwise>$0</xsl:otherwise>
																</xsl:choose>
															</xsl:when>
															<xsl:otherwise>$0</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:when test="$display-state = '14'">$0</xsl:when>
											<xsl:when test="$display-state = '15'"><!-- intentionally left empty for now --></xsl:when>
											<xsl:when test="$display-state = '16'">$0</xsl:when>
										</xsl:choose>
										<xsl:if test="$display-state != '1' and $display-state != '21' and $display-state != '31'">
											
											<xsl:choose>
												<xsl:when test="$mrc-warning-to-320-autopay='true' or $mrc-warning-from-320='true'">
													<span style="font-size:30px;color:#ff0000">*</span>
												</xsl:when>
												<xsl:when test="$mrc-discount='eligible'"><a href="#discountDetails_eligible" rel="#discountDetails_eligible" class="discount-eligible" style="height: 22px; width: 56px;background:none;text-indent:0px;text-decoration:none"><img src="${base_url_secure}/_img/activation/5dollar_icon_small_off_dark.png" alt="save $5" style="vertical-align:middle;margin-left:5px;"/></a></xsl:when>
												<xsl:when test="$mrc-discount='applied'"><a href="#discountDetails_applied" rel="#discountDetails_applied" class="discount-applied" style="height: 22px; width: 56px;background:none;text-indent:0px;text-decoration:none"><img src="${base_url_secure}/_img/activation/5dollar_icon_small_on.png" alt="save $5" style="vertical-align:middle;margin-left:5px;"/></a></xsl:when>
											</xsl:choose>
											


											


										</xsl:if>
									</p>
								</div>
								
								<xsl:if test="$display-state = '1' or $display-state = '21' or $display-state = '31'">
									<div class="mathsign-minus">-</div>
								</xsl:if>
								
							<xsl:if test="$plan-cos!='COS402' and $plan-cos!='COS405' and $plan-cos!='COS199' and $plan-cos!='COS41' and $plan-cos!='COS20' and $plan-cos!='COS42'">
								<div id="module2" class="info-module">
									<h3>
										<xsl:choose>
											<xsl:when test="$display-state = '1'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '18'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '2'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '21'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '3'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '31'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '4'">Anytime Minutes Used</xsl:when>
											<xsl:when test="$display-state = '5'">Anytime Minutes Used</xsl:when>
											<xsl:when test="$display-state = '6'">Anytime Minutes Used</xsl:when>
											<xsl:when test="$display-state = '7'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '17'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '19'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '20'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '8'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '9'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '10'">Anytime Minutes Used</xsl:when>
											<xsl:when test="$display-state = '11'">Anytime Minutes Used</xsl:when>
											<xsl:when test="$display-state = '12'">Anytime Minutes Used</xsl:when>
											<xsl:when test="$display-state = '13'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '14'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '15'">Current Balance</xsl:when>
											<xsl:when test="$display-state = '16'">Current Balance</xsl:when>
										</xsl:choose>
									</h3>
									
									<xsl:if test="$display-state !='4' and $display-state !='5' and $display-state !='6' and $display-state !='10' and $display-state !='11' and $display-state !='12'">
										
									</xsl:if>
									<p>
										<xsl:choose>
											<xsl:when test="$display-state = '1'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '18'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '2'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '21'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '3'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '31'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '4'"><xsl:value-of select="/vmu-page/account-info/activity/at-mins" /></xsl:when>
											<xsl:when test="$display-state = '5'"><xsl:value-of select="/vmu-page/account-info/activity/at-mins" /></xsl:when>
											<xsl:when test="$display-state = '6'"><xsl:value-of select="/vmu-page/account-info/activity/at-mins" /></xsl:when>
											<xsl:when test="$display-state = '7'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '17'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '19'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '20'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '8'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '9'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '10'"><xsl:value-of select="/vmu-page/account-info/activity/at-mins" /></xsl:when>
											<xsl:when test="$display-state = '11'"><xsl:value-of select="/vmu-page/account-info/activity/at-mins" /></xsl:when>
											<xsl:when test="$display-state = '12'"><xsl:value-of select="/vmu-page/account-info/activity/at-mins" /></xsl:when>
											<xsl:when test="$display-state = '13'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '14'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '15'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
											<xsl:when test="$display-state = '16'"><xsl:value-of select="/vmu-page/account-info/balance-string" /></xsl:when>
										</xsl:choose>
									</p>
								</div>
								</xsl:if>

								<xsl:if test="$display-state = '1' or $display-state = '21' or $display-state = '31'">
									<div class="mathsign-equals">=</div>
								</xsl:if>
								
								<div class="info-module" id="action_box">
									<xsl:if test="$display-state = '1' or $display-state = '21' or $display-state = '31'">
										<div id="module3" class="info-module">
											<h3>Min. Amt. Due</h3>
											
											<p>
												<xsl:choose>
													<xsl:when test="$display-state = '1'">
														<xsl:choose>
															<xsl:when test="$paylo-monthly='true'">
																$<xsl:value-of select="format-number(number(translate(/vmu-page/account-info/plan-info/total,'$','')) - number(translate(/vmu-page/account-info/balance-string,'$','')),'0.00')" />
															</xsl:when>
															<xsl:otherwise>
																$<xsl:value-of select="format-number(number(translate(/vmu-page/account-info/next-payment-due/total,'$','')) - number(translate(/vmu-page/account-info/balance-string,'$','')),'0.00')" />
															</xsl:otherwise>
														</xsl:choose>
													</xsl:when>
													<xsl:when test="$display-state = '21'">
														<xsl:choose>
															<xsl:when test="$paylo-monthly='true'">$<xsl:value-of select="format-number(number(translate(/vmu-page/account-info/plan-info/total,'$','')) - number(translate(/vmu-page/account-info/balance-string,'$','')),'0.00')" /></xsl:when>
															<xsl:otherwise>$<xsl:value-of select="format-number(number(translate(/vmu-page/account-info/next-payment-due/total,'$','')) - number(translate(/vmu-page/account-info/balance-string,'$','')),'0.00')" />
															</xsl:otherwise>
														</xsl:choose>
													</xsl:when>
													<xsl:when test="$display-state = '31'">
														<xsl:choose>
															<xsl:when test="$paylo-monthly='true'">$<xsl:value-of select="format-number(number(translate(/vmu-page/account-info/plan-info/total,'$','')) - number(translate(/vmu-page/account-info/balance-string,'$','')),'0.00')" /></xsl:when>
															<xsl:otherwise>$<xsl:value-of select="format-number(number(translate(/vmu-page/account-info/next-payment-due/total,'$','')) - number(translate(/vmu-page/account-info/balance-string,'$','')),'0.00')" />
															</xsl:otherwise>
														</xsl:choose>
													</xsl:when>
												</xsl:choose>
												<xsl:choose>
													<xsl:when test="$mrc-warning-to-320-autopay='true' or $mrc-warning-from-320='true'">
														<span style="font-size:30px;color:#ff0000">*</span>
													</xsl:when>
													
												</xsl:choose>
											</p>
											
											
										</div>
									</xsl:if>
										<div id="module4" class="info-module">
											
											<h3>
												<xsl:choose>
													<xsl:when test="$display-state = '1'">Date Due</xsl:when>
													<xsl:when test="$display-state = '18'">Next Month Starts On</xsl:when>
													<xsl:when test="$display-state = '2'">Charge Will be deducted on</xsl:when>
													<xsl:when test="$display-state = '21'">Date Due</xsl:when>
													<xsl:when test="$display-state = '31' or $display-state = '3'">
													  <xsl:choose>
														  <xsl:when test="normalize-space(/vmu-page/account-info/needs-curing)='true' or normalize-space(/vmu-page/account-info/past-current)='true'">Date Due</xsl:when>
														  <xsl:when test="contains(/vmu-page/account-info/topup-by-date,'2002')">Date Due</xsl:when>
														  <xsl:otherwise>Date Due<!--Was--></xsl:otherwise>
													  </xsl:choose>
													</xsl:when>
													<xsl:when test="$display-state = '4' or $display-state = '1-4'">Pay By</xsl:when>
													<xsl:when test="$display-state = '5' or $display-state = '1-5'">Pay By</xsl:when>
													<xsl:when test="$display-state = '6' or $display-state = '1-6'">
													  <xsl:choose>
														  <xsl:when test="normalize-space(/vmu-page/account-info/needs-curing)='true' or normalize-space(/vmu-page/account-info/past-current)='true'">Date Due</xsl:when>
														  <xsl:when test="contains(/vmu-page/account-info/topup-by-date,'2002')">Date Due</xsl:when>
														  <xsl:otherwise>Date Due Was</xsl:otherwise>
													  </xsl:choose>
													</xsl:when>
													<xsl:when test="$display-state = '7'">You will be charged on</xsl:when>
													<xsl:when test="$display-state = '17'">Charge Will be deducted on</xsl:when>
													<xsl:when test="$display-state = '19'">Next Month Starts On</xsl:when>
													<xsl:when test="$display-state = '20'">Next Month Starts On</xsl:when>
													<xsl:when test="$display-state = '8'">You will be charged on</xsl:when>
													<xsl:when test="$display-state = '9'">
														 <xsl:choose>
															  <xsl:when test="normalize-space(/vmu-page/account-info/needs-curing)='true' or normalize-space(/vmu-page/account-info/past-current)='true'">Date Due</xsl:when>
															  <xsl:when test="contains(/vmu-page/account-info/topup-by-date,'2002')">Date Due</xsl:when>
															  <xsl:otherwise>You will be charged on</xsl:otherwise>
														 </xsl:choose>
													</xsl:when>
													<xsl:when test="$display-state = '10' or $display-state = '1-10'">Pay By</xsl:when>
													<xsl:when test="$display-state = '11' or $display-state = '1-11'">Pay By</xsl:when>
													<xsl:when test="$display-state = '12' or $display-state = '1-12'">Date Due Was</xsl:when>
													<xsl:when test="$display-state = '13'">Top-Up By</xsl:when>
													<xsl:when test="$display-state = '14'">Choose Plan By</xsl:when>
													<xsl:when test="$display-state = '15'">You will be charged on</xsl:when>
													<xsl:when test="$display-state = '16'">Your plan will start on</xsl:when>
												</xsl:choose>
											</h3>
											<p>
												<xsl:variable name="balance-info-display-date">
													<xsl:choose>
														<xsl:when test="$display-state = '13'"><xsl:value-of select="/vmu-page/account-info/topup-by-date"/></xsl:when>
														<xsl:when test="$display-state = '15'"><xsl:value-of select="/vmu-page/account-info/topup-by-date" /></xsl:when>
														<xsl:when test="$display-state = '16'"><xsl:value-of select="/vmu-page/account-info/pending-plan-migration/start-date" /></xsl:when>
														<xsl:when test="$display-state = '18'"><xsl:value-of select="normalize-space(/vmu-page/login-session/ctd-plus-1)" /></xsl:when>
														<xsl:when test="$display-state = '19'"><xsl:value-of select="normalize-space(/vmu-page/login-session/ctd-plus-1)" /></xsl:when>
														<xsl:when test="$display-state = '20'"><xsl:value-of select="normalize-space(/vmu-page/login-session/ctd-plus-1)" /></xsl:when>
														<xsl:when test="$display-state = '7' or $display-state = '17' or $display-state = '8' or $display-state = '9' or $display-state = '14'">
															<xsl:choose>
															  <xsl:when test="normalize-space(/vmu-page/account-info/needs-curing)='true' or normalize-space(/vmu-page/account-info/past-current)='true'">NOW</xsl:when>
															  <xsl:otherwise>
																   <xsl:value-of select="/vmu-page/account-info/plan-info/@expires" />
															  </xsl:otherwise>
															 </xsl:choose>
														</xsl:when>
														<xsl:otherwise>
															<xsl:choose>
																<xsl:when test="$plan-cos = 'COS601'">
																		<xsl:choose>
																			<xsl:when test="normalize-space(/vmu-page/account-info/needs-curing)='true' or normalize-space(/vmu-page/account-info/past-current)='true'">NOW</xsl:when>
																			<xsl:otherwise><xsl:value-of select="/vmu-page/account-info/next-payment-due/topup-by-date" /></xsl:otherwise>
																		</xsl:choose>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:choose>
																			<xsl:when test="normalize-space(/vmu-page/account-info/needs-curing)='true' or normalize-space(/vmu-page/account-info/past-current)='true'">NOW</xsl:when>
																			<xsl:otherwise>
																				<xsl:value-of select="/vmu-page/account-info/plan-info/@expires" />
																			</xsl:otherwise>
																	</xsl:choose>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
										
												<xsl:call-template name="dateFormat">
													<xsl:with-param name="dateString" select="$balance-info-display-date" />
													<xsl:with-param name="formatType" select="'mmddyy'" />
												</xsl:call-template>
											</p>
											
										</div>
									<xsl:if test="$display-state = '18' or $display-state = '1' or $display-state = '2' or $display-state = '19' or $display-state = '20' or $display-state = '21' or $display-state = '17' or $display-state = '7' or $display-state = '8' or $display-state = '9'">
										<span>
											<xsl:variable name="small-date">
												<xsl:choose>
													<xsl:when test="$display-state = '1' or $display-state = '2' or $display-state = '21' or $display-state = '17' or $display-state = '7' or $display-state = '8' or $display-state = '9'"><xsl:value-of select="normalize-space(/vmu-page/login-session/ctd-plus-1)" /></xsl:when>
													
													<xsl:when test="$display-state = '18'"><xsl:value-of select="normalize-space(/vmu-page/account-info/next-payment-due/topup-by-date)" /></xsl:when>
													
													<xsl:when test="$display-state = '19'"><xsl:value-of select="normalize-space(/vmu-page/account-info/next-payment-due/topup-by-date)" /></xsl:when>
													
													<xsl:when test="$display-state = '20'"><xsl:value-of select="normalize-space(/vmu-page/account-info/next-payment-due/topup-by-date)" /></xsl:when>
												</xsl:choose>
											</xsl:variable>
											<xsl:choose>
												<!-- The inclusion of this case for curing or past current might make the other cases irrelevant, at least the ones that deal with display states for past current or uncured accounts -->
												<xsl:when test="normalize-space(/vmu-page/account-info/needs-curing)='true' or normalize-space(/vmu-page/account-info/past-current)='true'">Service Will Expire On:
													<xsl:call-template name="dateFormat">
														<xsl:with-param name="dateString" select="$small-date" />
														<xsl:with-param name="formatType" select="'mmddyy'" />
													</xsl:call-template>
												</xsl:when>
												<!-- END The inclusion of this case for curing or past current might make the other cases irrelevant, at least the ones that deal with display states for past current or uncured accounts -->
												<xsl:when test="$display-state = '18'">Next Payment Due On&#160;
													<xsl:call-template name="dateFormat">
														<xsl:with-param name="dateString" select="$small-date" />
														<xsl:with-param name="formatType" select="'mmddyy'" />
													</xsl:call-template>
												</xsl:when>
												<xsl:when test="$display-state = '19'">Next Payment Due On&#160;
													<xsl:call-template name="dateFormat">
														<xsl:with-param name="dateString" select="$small-date" />
														<xsl:with-param name="formatType" select="'mmddyy'" />
													</xsl:call-template>
												</xsl:when>
												<xsl:when test="$display-state = '20'">Next Payment Due On&#160;
													<xsl:call-template name="dateFormat">
														<xsl:with-param name="dateString" select="$small-date" />
														<xsl:with-param name="formatType" select="'mmddyy'" />
													</xsl:call-template>
												</xsl:when>
												<xsl:when test="$display-state = '1' or $display-state = '2' or $display-state = '21' or $display-state = '17' or $display-state = '7' or $display-state = '8' or $display-state = '9'">
													New Month Starts
													<xsl:call-template name="dateFormat">
														<xsl:with-param name="dateString" select="$small-date" />
														<xsl:with-param name="formatType" select="'mmddyy'" />
													</xsl:call-template>
												</xsl:when>
											</xsl:choose>
										</span>
									</xsl:if>
								</div>
								<!-- Pay Now/Top-Up Now Button -->
								<div id="payment_button">
									<a class="btn btn-default btn-lg my_account_overlay col-md-12">
										<xsl:attribute name="id">
											<xsl:choose>
												<!-- I think I'm supposed to enable advance payment for assurance wireless accounts, but I'm not sure -->
												<!--<xsl:when test="$plan-cos = 'COS211' or $plan-cos = 'COS807' or $plan-cos = 'COS806' or $plan-cos = 'COS802' or $plan-cos = 'COS803' or $plan-cos = 'COS804' or $plan-cos = 'COS805'">-->
												<xsl:when test="$plan-cos = 'COS211' or $plan-cos = 'COS807' or $plan-cos = 'COS809'">topup_now_button</xsl:when>
												<xsl:otherwise>
													<xsl:choose>
														<xsl:when test="/vmu-page/account-info/advance-payment/@enabled = 'true'">pay_now_button</xsl:when>
														<xsl:otherwise>topup_now_button</xsl:otherwise>
													</xsl:choose>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
										<xsl:attribute name="href">
											<xsl:choose>
												<xsl:when test="/vmu-page/account-info/advance-payment/@enabled = 'true'">/myaccount/prepareAdvancePayment.do</xsl:when>
												<xsl:otherwise>/myaccount/topup.do</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
										<xsl:choose>
											<!-- I think i'm supposed to enable advance payment for assurance wireless monthly accounts, but I'm not sure. -->
											<!--<xsl:when test="$plan-cos = 'COS211' or $plan-cos = 'COS807' or $plan-cos = 'COS806' or $plan-cos = 'COS802' or $plan-cos = 'COS803' or $plan-cos = 'COS804' or $plan-cos = 'COS805'">-->
											<xsl:when test="$plan-cos = 'COS211' or $plan-cos = 'COS807' or $plan-cos = 'COS809'">Top-Up Now</xsl:when>
											<xsl:otherwise>
												<xsl:choose>
													<xsl:when test="/vmu-page/account-info/advance-payment/@enabled = 'true'">Pay Now</xsl:when>
													<xsl:otherwise>Top-Up Now</xsl:otherwise>
												</xsl:choose>
											</xsl:otherwise>
										</xsl:choose>
									</a>
									<xsl:choose>
										<xsl:when test="/vmu-page/account-info/advance-payment/@enabled = 'true'">
											<a rel="#popupContact" href="#popupContact" class="load-local" id="what">What is Pay Now?</a>
									  </xsl:when>
									</xsl:choose>
								</div>
							
						</div>
					</div>
					
					<!-- START PAYMENT METHOD STRIP FOR MONTHLY PLANS 301, 302, 303, 401 and 403, 802, 803, 804, 806 -->
					<xsl:if test="$paylo-monthly='true' or $plan-type='beyondtalk' or $plan-type='virginmobile' or $plan-cos = 'COS802' or $plan-cos = 'COS803' or $plan-cos = 'COS804' or $plan-cos = 'COS806' or $plan-cos = 'COS807' or $plan-cos = 'COS809' or $plan-cos = 'COS211'">
						<div class="details">
							
							<div id="payment_strip" class="col-md-12 well-gray">
								
								<p id="payment_strip_message">
									<strong>Payment Method: </strong> 
								 <xsl:choose>
									<xsl:when test="/vmu-page/account-info/payment-method/cc-flag = 'true'">
										<xsl:variable name="creditcardname">
											<xsl:call-template name="credit-card-number-display">
												<xsl:with-param name="cc-string"><xsl:value-of select="/vmu-page/account-info/payment-method/last-four-cc-number"/></xsl:with-param>
												<xsl:with-param name="cc-type"><xsl:value-of select="/vmu-page/account-info/payment-method/cc-type"/></xsl:with-param>
											</xsl:call-template>
										</xsl:variable>
										<xsl:choose>
											<xsl:when test="/vmu-page/account-info/payment-method/rpv-preferred-mrc = 'true'">
												<xsl:value-of select="$creditcardname"/>&#160;will be used to pay any future monthly charges.
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$creditcardname"/>&#160;will be saved for future use. Log in each month to pay or <a class="my_account_overlay" href="/myaccount/prepareCreditCardInformation.do">click here</a> to change your settings.
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:when test="/vmu-page/account-info/payment-method/paypal-flag = 'true'">
										<xsl:choose>
											<xsl:when test="/vmu-page/account-info/payment-method/rpv-preferred-mrc = 'true'">
												PayPal will be used to pay any future monthly charges.
											</xsl:when>
											<xsl:otherwise>
												PayPal will be saved for future use. Log in each month to pay or <a class="my_account_overlay" href="/myaccount/preparePayPal.do">click here</a> to change your settings.
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
								   <!-- Not really sure what happens if you have a checking account registered -->
									<xsl:when test="/vmu-page/account-info/payment-method/cheque-flag = 'true'">
										<xsl:choose>
											<xsl:when test="/vmu-page/account-info/payment-method/rpv-preferred-mrc = 'true'">
											</xsl:when>
											<xsl:otherwise>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
									Top up your cash balance each month using top up cards or a credit/debit card. <a class="my_account_overlay" href="/myaccount/prepareCreditCardInformation.do">Click here</a> to register a payment method.
									</xsl:otherwise>
								  </xsl:choose>
								</p>
								<xsl:choose>
									<xsl:when test="/vmu-page/account-info/payment-method/paypal-flag = 'true'">
										<p id="payment_strip_button"> <a class="my_account_overlay btn btn-default btn-small" href="/myaccount/preparePayPal.do">Edit</a></p>
									</xsl:when>
									<xsl:otherwise>
										<p id="payment_strip_button"> <a class="my_account_overlay btn btn-default btn-small" href="/myaccount/prepareCreditCardInformation.do">Edit</a></p>
									</xsl:otherwise>
								</xsl:choose>
							</div>
						</div>
					</xsl:if>
				</div>
			</div>
		
		</div>
	</div>
</xsl:template>


    <xsl:template name="account-activity-messages">
        <xsl:param name="plan-cos" />

        <xsl:variable name="message_plan" select="normalize-space(/vmu-page/account-info/messaging/msg-pack/name[position()=1])" />
        <xsl:variable name="message_plan_cost" select="normalize-space(/vmu-page/account-info/messaging/msg-pack/current-textbundle[position()=1]/cost)" />


        <xsl:choose>
            <xsl:when test="$message_plan = 'Pay per message'">15&#162; per text/25&#162; per pic</xsl:when>

            <!-- I don't see an equivalent of this in the new SOC table -->
            <xsl:when test="$message_plan = 'SMSBUNDLE_500_COS403'">1500 messages</xsl:when>
            <xsl:when test="$message_plan = 'SMSBUNDLE_UNLIMITED_COS404'">Unlimited messages</xsl:when>
            <xsl:when test="$message_plan = 'AW.MESSAGE_PACK_1000'">1000 messages</xsl:when>
            <xsl:when test="$message_plan = 'AW.SMSBUNDLE_1000_COS803'">1000 messages</xsl:when>
            <!-- end I don't see an equivalent of this in the new SOC table -->

            <xsl:when test="$message_plan = 'VASMS50' or contains($message_plan,'50 MSG') or contains($message_plan,'50 msgs')">50 messages/<br />$1.99 per month</xsl:when>
            <xsl:when test="$message_plan = 'VASMS30' or contains($message_plan,'30 MSG') or contains($message_plan,'30 msgs')">30 messages/<br />$1.99 per month</xsl:when>
            <xsl:when test="$message_plan = 'VASMS200' or contains($message_plan,'200 MSG') or contains($message_plan,'200 msgs')">200 messages/<br />$4.99 per month</xsl:when>
            <xsl:when test="$message_plan = 'VASMS750' or contains($message_plan,'750 MSG') or contains($message_plan,'750 msgs')">750 messages/<br />$?? per month</xsl:when>
            <xsl:when test="$message_plan = 'VASMS1000' or contains($message_plan,'1000 MSG') or contains($message_plan,'1000 msgs')">1000 messages/<br />$9.99 per month</xsl:when>
            <xsl:when test="$message_plan = 'VASMSUNLM' or contains($message_plan_cost,'$19.9')">Unlimited</xsl:when>

            <!-- I think these are deprecated -->
            <xsl:when test="$message_plan = 'SMSBUNDLE1000_BOLTON'">1000 messages/<br />$4.99 per month</xsl:when>
            <xsl:when test="$message_plan = 'SMSBUNDLEUNLIMITED_BOLTON'">Unlimited messages/<br />$9.99 per month</xsl:when>
            <xsl:otherwise>15&#162; per text/25&#162; per pic</xsl:otherwise>
            <!-- end I think these are deprecated -->
        </xsl:choose>		
    </xsl:template>

    <xsl:template name="account-activity-data">
        <xsl:param name="plan-cos" />

        <xsl:variable name="web_name" select="/vmu-page/account-info/datapack/active-datapack/name" />
        <xsl:choose>
            <xsl:when test="$web_name='VVXL1MB' or $web_name = 'BASIC'">$1.50 /MB/day</xsl:when>
            <!-- I don't see an equivalent of this in the new SOC table -->
            <xsl:when test="$web_name='V3G.DATA_PLAN.10MB_COS403'">50MBMB</xsl:when>
            <!-- end I don't see an equivalent of this in the new SOC table -->
            <!-- I don't see an equivalent of this in the new SOC table -->
            <xsl:when test="$web_name='V3G.DATA_PLAN.50MB_COS404'">50MB</xsl:when>
            <!-- end I don't see an equivalent of this in the new SOC table -->
            <!-- I think these are deprecated -->
            <xsl:when test="$web_name='V3G.DATA_PLAN.20MB_BOLTON'">20MB</xsl:when>
            <xsl:when test="$web_name='V3G.DATA_PLAN.50MB_BOLTON'">50MB</xsl:when>
            <!-- end I think these are deprecated -->
            <xsl:when test="$web_name = 'VADAT5MB' or contains($web_name,'5MB') or contains($web_name,'5 MB')">5MB for $5</xsl:when>
            <xsl:when test="$web_name = 'VADAT20MB' or contains($web_name,'20MB') or contains($web_name,'20 MB')">20MB for $10</xsl:when>
            <xsl:when test="$web_name = 'VADAT50MB' or contains($web_name,'50MB') or contains($web_name,'50 MB')">50MB for $20</xsl:when>
            <xsl:when test="$web_name='None'">None</xsl:when>
            <xsl:otherwise>None</xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template name="aw-messaging-pack-display">
        <xsl:variable name="aw-bolton-name" select="$current-aw-bolton"/>
        <xsl:variable name="messaging-pack-name" select="normalize-space(/vmu-page/account-info/messaging/msg-pack/name[position()=1])"/>
        <xsl:variable name="bonus-texts-active" select="/vmu-page/account-info/messaging/msg-pack/bonus-subscription/@active"/>
        <xsl:variable name="has-messaging-pack">
            <xsl:choose>
                <xsl:when test="$messaging-pack-name != 'Pay per message' and $messaging-pack-name != 'None' and $messaging-pack-name !='none' and $messaging-pack-name !=''">true</xsl:when>
                <xsl:otherwise>false</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- COS807 gets 250 free texts by default, but do not show them if the user has the unlimited bolton -->
        <xsl:if test="$plan-cos='COS807'">
        <tr>
            <th>Free Texts</th>
            <td>250</td>
        </tr>
        </xsl:if>

        <xsl:if test="contains($plan-cos,'COS815')">
            <tr>
                <th>Free Texts</th>
                <td>Unlimited</td>
            </tr>
        </xsl:if>
        <xsl:if test="contains($plan-cos,'COS816')">
            <tr>
                <th>Free Texts</th>
                <td>Unlimited</td>
            </tr>
        </xsl:if>
        <!-- end COS807 gets 250 free texts by default, but do not show them if the user has the unlimited bolton -->

        <xsl:choose>

            <xsl:when test="$aw-bolton-name='ASW30BOLT'">
                <tr>
                    <th>Purchased Texts</th>
                    <td>Unlimited</td>
                </tr>
            </xsl:when>
            <!-- COS211 Text Bolton-->
            <xsl:when test="$aw-bolton-name='ASW20BOLT'">
                <tr>
                    <th>Purchased Texts</th>
                    <td>1000</td>
                </tr>
            <!-- END COS211 -->
            </xsl:when>
            <!-- COS807 Boltons-->
            <xsl:when test="$aw-bolton-name='AWMISDUNL'">
                <tr>
                    <th>Purchased Texts</th>
                    <td>Unlimited</td>
                </tr>
            </xsl:when>
            <xsl:when test="$aw-bolton-name='AWMISM250'">
                <tr>
                    <th>Purchased Texts</th>
                    <td>250</td>
                </tr>
            </xsl:when>
            <xsl:when test="$aw-bolton-name='AWMISM750'">
                <tr>
                    <th>Purchased Texts</th>
                    <td>750</td>
                </tr>
            </xsl:when>
            <!-- END COS807 -->


            <!-- COS810 -->
            <xsl:when test="contains($plan-cos,'COS810')">
                <tr>
                    <th>Texts</th>
                    <td>Unlimited</td>
                </tr>
            </xsl:when>
            <!-- END COS810 -->
            <!-- COS806 -->
            <xsl:when test="$plan-cos='COS806'">
                <tr>
                    <th>Texts</th>
                    <td>Unlimited</td>
                </tr>
            </xsl:when>
            <!-- END COS806 -->
            <!-- COS802 -->
            <xsl:when test="$plan-cos='COS802'">
                <tr>
                    <th>Texts</th>
                    <td>500</td>
                </tr>
            </xsl:when>
            <!-- END COS 802 -->
            <!-- COS803 -->
            <xsl:when test="$plan-cos='COS803'">
                <tr>
                    <th>Texts</th>
                    <td>1000</td>
                </tr>
            </xsl:when>
            <!-- END COS803 -->
        </xsl:choose>

        <!-- PROMOTIONAL BOLTONS -->
        <!-- not sure if I should hide the promotional messages from plans that have unlimited messages built in.-->
        <xsl:if test="$current-aw-promotional-offer='talkandtext'">
            <tr>
                <th>Promotional Texts</th>
                <td>250</td>
            </tr>
        </xsl:if>
        <!-- END PROMOTIONAL BOLTONS -->

        <!-- if the user has a pack -->
        <xsl:if test="$has-messaging-pack='true'">
            <tr>
                <th>Messaging Pack</th>
                <td>
                    <xsl:call-template name="account-activity-messages">
                        <xsl:with-param name="plan-cos" select="$plan-cos" />
                    </xsl:call-template>
                </td>
            </tr>
        </xsl:if>
        <!-- end if the user has a pack -->

        <!-- bonus texts -->
        <xsl:if test="$bonus-texts-active = 'true'">
            <tr>
                <th>Remaining Bonus Texts</th>
                <td><xsl:value-of select="format-number(/vmu-page/account-info/messaging/msg-pack/bonus-subscription/msgs-left,0)"/></td>
            </tr>
        </xsl:if>
        <!-- end bonus texts -->

        <!-- Additional messages are 10 cents each. in the case of 806, 804, 801 and 805, if the user does not have a messaging pack, the label should just be "Texts." -->
        <xsl:choose>
            <xsl:when test="($plan-cos='COS807' or $plan-cos='COS211' or $plan-cos='COS802' or $plan-cos='COS803') and $current-aw-bolton!='AWMISDUNL' and $current-aw-bolton!='ASW30BOLT'">
                <tr>
                    <th>Additional Texts</th>
                    <td>10&#162; each</td>
                </tr>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$plan-cos!='COS807' and $plan-cos!='COS211' and $plan-cos!='COS802' and $plan-cos!='COS803'  and $plan-cos!='COS815' and $plan-cos!='COS816' and not(contains($plan-cos,'COS810'))">
                        <xsl:choose>
                            <xsl:when test="$has-messaging-pack='true'">
                                <tr>
                                    <th>Additional Texts</th>
                                    <td>10&#162; each</td>
                                </tr>
                            </xsl:when>
                            <xsl:otherwise>
                                <tr>
                                    <th>Texts</th>
                                    <td>10&#162; each</td>
                                </tr>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="aw-data-pack-display">
        <xsl:choose>
            <xsl:when test="$plan-cos='COS806'">
                <tr>
                    <th>Data</th>
                    <td>Unlimited</td>
                </tr>
            </xsl:when>
            <xsl:when test="$current-aw-bolton = 'AWMISDUNL'">
                <tr>
                    <th>Purchased Data</th>
                    <td>Unlimited</td>
                </tr>
            </xsl:when>
            <xsl:when test="$current-aw-bolton = 'AWMISDUNL' or $current-aw-bolton='ASW30BOLT' or contains($current-aw-bolton,'$30')">
                <tr>
                    <th>Purchased Data</th>
                    <td>Unlimited</td>
                </tr>
            </xsl:when>
            <xsl:when test="normalize-space(/vmu-page/account-info/datapack/active-datapack/name) != 'None' and  normalize-space(/vmu-page/account-info/datapack/active-datapack/name) != 'none' and normalize-space(/vmu-page/account-info/datapack/active-datapack/name) != ''">
                <tr>
                    <th>Data Pack</th>
                    <td>
                        <xsl:call-template name="account-activity-data">
                            <xsl:with-param name="plan-cos" select="$plan-cos" />
                        </xsl:call-template>
                    </td>
                </tr>
            </xsl:when>
        </xsl:choose>
    </xsl:template>


    <xsl:template name="discount-icon">
        <xsl:choose>
            <xsl:when test="$mrc-discount='eligible'">
            <a href="#discountDetails_eligible" rel="#discountDetails_eligible" class="discount-eligible" style="height: 46px; width: 70px;"><img src="${base_url_secure}
    /_img/activation/5dollar_icon_small_off.png" alt="save $5" style="vertical-align:middle;width:40%;"/></a>&#160;
            </xsl:when>
            <xsl:when test="$mrc-discount='applied'">
            <a href="#discountDetails_applied" rel="#discountDetails_applied" class="discount-applied" style="height: 46px; width: 70px;"><img src="${base_url_secure}
    /_img/activation/5dollar_icon_small_on.png" alt="save $5" style="vertical-align:middle;width:40%;"/></a>&#160;
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="discount-icon-top">
        <xsl:param name="plan-cost-for-icon"/>
        <xsl:choose>
            <xsl:when test="$mrc-discount='eligible'">
                <div style="width:165px;" class="clearfix">
                    <h3 style="float:left;width:100px"><xsl:value-of select="$plan-cost-for-icon"/> Beyond Talk</h3>
                        <a href="#discountDetails_eligible" rel="#discountDetails_eligible" class="discount-eligible" style="float:left;height: 22px; width: 57px;background:none;text-indent:0px;"><img src="${base_url_secure}/_img/activation/5dollar_icon_small_off_dark.png" alt="save $5" style="vertical-align:bottom;width:80%;margin-top:5px;"/></a>
                </div>
            </xsl:when>
            <xsl:when test="$mrc-discount='applied'">
                <div style="width:165px;" class="clearfix">
                    <h3 style="float:left;width:100px"><xsl:value-of select="$plan-cost-for-icon"/> Beyond Talk</h3>
                        <a href="#discountDetails_applied" rel="#discountDetails_applied" class="discount-applied" style="float:left;height: 22px; width: 57px;background:none;text-indent:0px;"><img src="${base_url_secure}/_img/activation/5dollar_icon_small_on.png" alt="save $5" style="vertical-align:bottom;width:80%;margin-top:5px;"/></a>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <h3><xsl:value-of select="$plan-cost-for-icon"/> Beyond Talk</h3>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="personalized-message">
        <xsl:param name="message-key"/>
        <xsl:comment>nothing</xsl:comment>
    </xsl:template> 
</xsl:stylesheet>