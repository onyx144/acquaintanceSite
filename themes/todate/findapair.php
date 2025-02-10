<?php global $db,$_LIBS; ?>
<!-- Pro Users  -->
<div class="container page-margin">
    <style>
      .to_pro_users {
    display: none;
}  
    </style>
	<?php if(IS_LOGGED && !empty($profile) && $profile->verified !== "1") { ?>
		<div class="alert alert-warning"><?php echo __('account_not_verified_text'); ?></div>
	<?php } ?>
	
	<div class="location_alert_update">
		<?php if(IS_LOGGED && !empty($profile) && (empty($profile->lat) || empty($profile->lng))) { ?>
			<div class="alert alert-warning"><?php echo __('please_enable_location'); ?></div>
		<?php } ?>
	</div>
	
    <?php
    if (IsThereAnnouncement() === true) {
        $announcement = GetHomeAnnouncements();
        ?>
        <div class="home-announcement">
            <div class="alert alert-success" style="background-color: white;">
                    <span class="close announcements-option" data-toggle="tooltip" onclick="Wo_ViewAnnouncement(<?php echo $announcement['id']; ?>);" title="<?php echo __('Hide');?>" style="float: right;cursor: pointer;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M19,6.41L17.59,5L12,10.59L6.41,5L5,6.41L10.59,12L5,17.59L6.41,19L12,13.41L17.59,19L19,17.59L13.41,12L19,6.41Z"></path></svg>
                    </span>
                <?php echo $announcement['text']; ?>
            </div>
        </div>
        <!-- .home-announcement -->
    <?php } ?>
		
	<?php if( $config->pro_system == 1 ){ ?>
		<?php require( $theme_path . 'main' . $_DS . 'pro-users.php' );?>
	<?php } ?>
		
	<?php
		$_SESSION['_lat'] = $profile->lat;
		$_SESSION['_lng'] = $profile->lng;

		$_age_from = !empty($data['find_match_data']) && !empty($data['find_match_data']['age_from']) ? $data['find_match_data']['age_from'] : 18;
		$_age_to = !empty($data['find_match_data']) && !empty($data['find_match_data']['age_to']) ? $data['find_match_data']['age_to'] : 98;
		$_located = !empty($data['find_match_data']) && !empty($data['find_match_data']['located']) ? $data['find_match_data']['located'] : 125;
		$_gender = !empty($data['find_match_data']) && !empty($data['find_match_data']['gender']) ? $data['find_match_data']['gender'] : array();

		$_location = '';
		$_gender_text = '';
		$_gender_ = array();
		$gender = Dataset::load('gender');
		if(!empty($_gender) && count($_gender) != count($gender)){
			//$_gender = @implode(',', $_gender);
			foreach( $_gender as $key => $value ) {
				$_gender_[$value] = Dataset::gender()[$value];
			}
			$_gender_text = implode(',',$_gender_);
		}else{
			$_gender_text = __('All');
		}
	?>
	
	<div class="valign-wrapper to_page_title">
		<h3 class="valign-wrapper"><span><svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 24 24"><path fill="currentColor" d="M21.47,4.35L20.13,3.79V12.82L22.56,6.96C22.97,5.94 22.5,4.77 21.47,4.35M1.97,8.05L6.93,20C7.24,20.77 7.97,21.24 8.74,21.26C9,21.26 9.27,21.21 9.53,21.1L16.9,18.05C17.65,17.74 18.11,17 18.13,16.26C18.14,16 18.09,15.71 18,15.45L13,3.5C12.71,2.73 11.97,2.26 11.19,2.25C10.93,2.25 10.67,2.31 10.42,2.4L3.06,5.45C2.04,5.87 1.55,7.04 1.97,8.05M18.12,4.25A2,2 0 0,0 16.12,2.25H14.67L18.12,10.59"></path></svg></span> <?php echo __( 'Find Matches' );?></h3>

	</div>
		
	<!-- Match Users  -->
	<div id="section_match_users" class="<?php echo $match_style;?>">
		<?php if (empty($data['matches'])) { ?>
			<div id="_load_more" class="empty_state"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path d="M2 22a8 8 0 1 1 16 0H2zm8-9c-3.315 0-6-2.685-6-6s2.685-6 6-6 6 2.685 6 6-2.685 6-6 6zm7.363 2.233A7.505 7.505 0 0 1 22.983 22H20c0-2.61-1-4.986-2.637-6.767zm-2.023-2.276A7.98 7.98 0 0 0 18 7a7.964 7.964 0 0 0-1.015-3.903A5 5 0 0 1 21 8a4.999 4.999 0 0 1-5.66 4.957z" fill="currentColor"/></svg><?php echo __( 'view_no_more_to_show' );?></div>
		<?php } else { ?>
			<div class="dt_home_match_user">
				<div class="mtc_usr_details" id="match_item_container">
					<?php echo $data['matches']; ?>
				</div>
				<div class="mtc_usr_avtr" id="avaters_item_container">
					<?php echo $data['matches_img']; ?>
				</div>
			</div>
		<?php } ?>
	</div>
	<!-- End Match Users  -->
		
	<?php
		$max_swaps = $config->max_swaps;
		$count_swipe_for_this_day = GetUserTotalSwipes(auth()->id);
		$last_swipe = $db->where('user_id', auth()->id)->orderBy('created_at','DESC')->get('likes', 1, array('created_at'));
		if(isset($last_swipe[0])) {
			$raminhours = 24 - intval(date('H', time() - strtotime($last_swipe[0]['created_at'])));
		}else{
			$raminhours = 24;
		}

		$warning_style='';
		$match_style='';
		//if($count_swipe_for_this_day >= $max_swaps) {
		//$warning_style='';
		//$match_style='hide';
		//}else{
		//$warning_style='hide';
		//$match_style='';
		//}
	?>
	<!--<div id="max_swipes_reached" class="empty_state <?php echo $warning_style;?>">
		<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path d="M12 22C6.477 22 2 17.523 2 12S6.477 2 12 2s10 4.477 10 10-4.477 10-10 10zm0-2a8 8 0 1 0 0-16 8 8 0 0 0 0 16zM7 9l3-3.5L13 9h-2v4H9V9H7zm10 6l-3 3.5-3-3.5h2v-4h2v4h2z" fill="currentColor"/></svg>
		<p id="w_message"><?php echo str_replace('{0}',$raminhours, __('You reach the max of swipes per day. you have to wait {0} hours before you can redo likes Or upgrade to pro to for unlimited.') );?></p>
	</div>-->

	<a href="javascript:void(0);" style="display: none;" id="btn_load_more_match_users" data-lang-loadmore="<?php echo __('Load more...');?>" data-lang-nomore="<?php echo __('No more users to show.');?>" data-ajax-post="/loadmore/match_users" data-ajax-params="page=2" data-ajax-callback="callback_load_more_match_users" class="load_more"><span><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M7.41,8.58L12,13.17L16.59,8.58L18,10L12,16L6,10L7.41,8.58Z"></path></svg></span> <?php echo __('Load more...');?></a>
	<!-- End Match Users  -->


	<!-- Search Users  -->
	<div class="hide" id="latest_user">
		<div class="dt_home_rand_user">
			<div class="row r_margin" id="search_users_container"></div>

			<a href="javascript:void(0);" id="btn_load_more_search_users" data-lang-more="<?php echo __('Load more...');?>" data-lang-nomore="<?php echo __('view_no_more_to_show');?>" data-ajax-post="/loadmore/find_matches" data-ajax-params="page=2" data-ajax-callback="callback_load_more_search_users" class="load_more hide"><span><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M7.41,8.58L12,13.17L16.59,8.58L18,10L12,16L6,10L7.41,8.58Z"></path></svg></span> <?php echo __('Load more...');?></a>
		</div>
	</div>
	<!-- End Search Users  -->
		
	<!-- Filters  -->
	<div id="filtr_slide_out" class="modal bottom-sheet to_side_filters">
		<div class="colla_prnt">
		<ul class="collapsible">
			<li>
				<div class="collapsible-header"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path d="M8 4h13v2H8V4zM4.5 6.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm0 7a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm0 6.9a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zM8 11h13v2H8v-2zm0 7h13v2H8v-2z" fill="currentColor"/></svg> <?php echo __('Basic');?></div>
				<div class="collapsible-body">
					<form onsubmit="return false;" onkeypress="return event.keyCode != 13;">
						<div class="to_side_filters_innrlist">
							<h5><?php echo __('Gender');?></h5>
							<div>
								<?php
									$all_gender = array();
									$gender = Dataset::load('gender');
									$all_checked = '';
									if( empty($_gender) || count($_gender) == count($gender) ){
										$all_checked = 'checked';
									}
									if (isset($gender) && !empty($gender)) {
										foreach ($gender as $key => $val) {
											$all_gender[] = $key;
											$_checked = '';
											if( !empty($_gender)){
												if(in_array($key, $_gender) && empty($all_checked)){
													$_checked = 'checked';
												}
											}
											echo '<p class="filtr_cbox"><label><input type="checkbox" class="_gender browser-default" value="' . $key . '" data-txt="' . $val . '" '.$_checked.'  data-vx="' . $key . '"/><span class="_gender_text" data-txt="' . $val . '">' . $val . '</span></label></p>';
										}
									}
									if (empty($_gender)) {
										$all_checked = 'checked';
									}
								?>
								<p class="filtr_cbox"><label><input type="checkbox" class="_gender browser-default" value="<?php echo implode(",",$all_gender);?>" data-vx="_all_" data-txt="<?php echo __('All');?>" <?php echo $all_checked;?> /><span class="_gender_text" data-txt="<?php echo __('All');?>"><?php echo __('All');?></span></label></p>
							</div>
						</div>
						<?php if($config->filter_by_country == 'ALL' || ($config->filter_by_country == 'PRO' && ($profile->is_pro == 1 || $config->pro_system == 0))){
							$active_show_me_to = $profile->show_me_to;
						?>
						<div class="to_side_filters_innrlist">
							<h5><?php echo __('Location');?></h5>
							<div>
								<div class="valign-wrapper">
									<select id="my_country" name="my_country" class="browser-default" data-country="<?php echo $profile->country;?>" <?php if(!empty($data['find_match_data']) && !empty($data['find_match_data']['located'])) {?>disabled="disabled"<?php }?>  <?php if($config->filter_by_cities == 1 && !empty($config->geo_username)){ ?>onchange="ChangeCountryKey(this)"<?php } ?>>
										<option value="all" <?php echo(!empty($data['find_match_data']) && !empty($data['find_match_data']['country']) && $data['find_match_data']['country'] == 'all') ? 'selected' : '' ?>><?php echo __('all_countries');?></option>
										<?php
											$city_country_key = '';
											foreach( Dataset::load('countries') as $key => $val ){
												if ($profile->country == $key) {
													$city_country_key = $key;
												}
												$selected = '';
												if (!empty($data['find_match_data']) && !empty($data['find_match_data']['country']) && $data['find_match_data']['country'] == $key) {
													$city_country_key = $key;
													$selected = 'selected';
												}
												echo '<option value="'. $key .'" data-code="'. $val['isd'] .'"  '. ($selected) . ' ' . ( (  $profile->country == $key  ) ? 'data-country="true"' : 'data-country="false"' ) .'>'. $val['name'] .'</option>';
											}
										?>
									</select>
									
									<label class="locate_me" title="<?php echo __('My location');?>">
										<input type="checkbox" class="filled-in" <?php if(!empty($data['find_match_data']) && !empty($data['find_match_data']['located'])){ ?>checked="checked"<?php }?> id="is_my_location">
										<b><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M12,8A4,4 0 0,1 16,12A4,4 0 0,1 12,16A4,4 0 0,1 8,12A4,4 0 0,1 12,8M3.05,13H1V11H3.05C3.5,6.83 6.83,3.5 11,3.05V1H13V3.05C17.17,3.5 20.5,6.83 20.95,11H23V13H20.95C20.5,17.17 17.17,20.5 13,20.95V23H11V20.95C6.83,20.5 3.5,17.17 3.05,13M12,5A7,7 0 0,0 5,12A7,7 0 0,0 12,19A7,7 0 0,0 19,12A7,7 0 0,0 12,5Z" /></svg></b>
									</label>
								</div>
								<?php if ($config->filter_by_cities == 1) { ?>
									<div class="input-field">
										<input type="hidden" class="city_country_key" name="city_country_key" value="<?php echo($city_country_key); ?>">
										<input type="text" name="city" placeholder="<?php echo __( 'City' );?>" <?php if($config->filter_by_cities == 1 && !empty($config->geo_username)){ ?>onkeyup="SearchForCity(this)"<?php } ?> class="selected_city" value="<?php echo(!empty($data['find_match_data']) && !empty($data['find_match_data']['city']) ? $data['find_match_data']['city'] : '') ?>">
										<div class="city_search_result"></div>
									</div>
								<?php } ?>
							</div>
						</div>
						<?php } ?>
						<div class="to_side_filters_innrlist">
							<h5><?php echo __('Ages');?></h5>
							<div>
								<div class="row r_margin">
									<div class="input-field col s6">
										<select class="_age_from browser-default">
											<?php for($i = 18 ; $i < 51 ; $i++ ){
											$selected = '';
											if (!empty($data['find_match_data']) && !empty($data['find_match_data']['age_from']) && $data['find_match_data']['age_from'] == $i) {
												$selected = 'selected';
											}
											?>
												<option value="<?php echo $i;?>" <?php echo $selected; ?> ><?php echo $i;?></option>
											<?php }?>
										</select>
									</div>
									<div class="input-field col s6">
										<select class="_age_to browser-default">
											<?php for($i = 51 ; $i < 99 ; $i++ ){
											$selected = '';
											if (!empty($data['find_match_data']) && !empty($data['find_match_data']['age_to']) && $data['find_match_data']['age_to'] == $i) {
												$selected = 'selected';
											}
											else if(empty($data['find_match_data']['age_to']) && $i == 98){
												$selected = 'selected';
											}
											?>
												<option value="<?php echo $i;?>" <?php echo $selected; ?> ><?php echo $i;?></option>
											<?php }?>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="to_side_filters_innrlist">
							<h5><?php echo __('Distance');?></h5>
							<div>
								<p class="range-field">
									<input type="range" min="1" max="250" value="<?php echo !empty($data['find_match_data']) && !empty($data['find_match_data']['located']) ? $data['find_match_data']['located'] : 125 ;?>" id="_located" <?php if(!empty($data['find_match_data']) && empty($data['find_match_data']['located'])) {?>disabled="disabled"<?php }?>/>
								</p>
							</div>
						</div>
						<input type="hidden" id="_lat" value="<?php echo $profile->lat;?>">
						<input type="hidden" id="_lng" value="<?php echo $profile->lng;?>">
						<div class="center">
							<button class="btn reset_search" type="button" id="btn_search_basic" onclick="resetSearchData()"><?php echo __('reset');?></button>
							<button class="btn btn_primary btn-find-matches-search" type="button" id="btn_search_basic" disabled><?php echo __('Search');?></button>
						</div>
					</form>
				</div>
			</li>
			<li>
				<div class="collapsible-header"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path d="M20 22h-2v-2a3 3 0 0 0-3-3H9a3 3 0 0 0-3 3v2H4v-2a5 5 0 0 1 5-5h6a5 5 0 0 1 5 5v2zm-8-9a6 6 0 1 1 0-12 6 6 0 0 1 0 12zm0-2a4 4 0 1 0 0-8 4 4 0 0 0 0 8z" fill="currentColor"/></svg> <?php echo __('Looks');?></div>
				<div class="collapsible-body">
					<form onsubmit="return false;" onkeypress="return event.keyCode != 13;">
						<div class="to_side_filters_innrlist">
							<h5><?php echo __('Height');?></h5>
							<div>
								<div class="row r_margin">
									<div class="input-field col s6">
										<select class="height_from browser-default">
											<?php 
											$height = Dataset::load('height');
											if (isset($height) && !empty($height)) {
												foreach ($height as $key => $val) {
													if ($key < 170) {
														$selected = '';
														if (!empty($data['find_match_data']) && !empty($data['find_match_data']['height_from']) && $data['find_match_data']['height_from'] == $key) {
															$selected = 'selected';
														}
														else if(empty($data['find_match_data']['height_from']) && $key == 139){
															$selected = 'selected';
														}
												 ?>
													<option value="<?php echo($key) ?>" <?php echo $selected; ?>><?php echo($val) ?></option>
											<?php } } } ?>
										</select>
									</div>
									<div class="input-field col s6">
										<select class="height_to browser-default">
											<?php 
											$height = Dataset::load('height');
											if (isset($height) && !empty($height)) {
												foreach ($height as $key => $val) {
													if ($key >= 170) {
														$selected = '';
														if (!empty($data['find_match_data']) && !empty($data['find_match_data']['height_to']) && $data['find_match_data']['height_to'] == $key) {
															$selected = 'selected';
														}
														else if(empty($data['find_match_data']['height_to']) && $key == 220){
															$selected = 'selected';
														}
												 ?>
													<option value="<?php echo($key) ?>" <?php echo $selected; ?>><?php echo($val) ?></option>
											<?php } } } ?>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="to_side_filters_innrlist">
							<h5><?php echo __('Body type');?></h5>
							<div>
								<?php
									$body = Dataset::load('body');
									if (isset($body) && !empty($body)) {
										foreach ($body as $key => $val) {
											$selected = '';
											if (!empty($data['find_match_data']) && !empty($data['find_match_data']['body']) && in_array($key, $data['find_match_data']['body'])) {
												$selected = 'checked';
											}
											echo '<p class="filtr_cbox"><label><input type="checkbox" class="_body" value="' . $key . '" data-txt="' . $val . '" '.$selected.'/><span>' . $val . '</span></label></p>';
										}
									}
								?>
							</div>
						</div>
						<div class="center">
							<button class="btn reset_search" type="button" id="btn_search_basic" onclick="resetSearchData()"><?php echo __('reset');?></button>
							<button class="btn btn_primary btn-find-matches-search" id="btn_search_looks" type="button" disabled><?php echo __('Search');?></button>
						</div>
					</form>
				</div>
			</li>
			<li>
				<div class="collapsible-header"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path d="M19 22H5a3 3 0 0 1-3-3V3a1 1 0 0 1 1-1h14a1 1 0 0 1 1 1v12h4v4a3 3 0 0 1-3 3zm-1-5v2a1 1 0 0 0 2 0v-2h-2zm-2 3V4H4v15a1 1 0 0 0 1 1h11zM6 7h8v2H6V7zm0 4h8v2H6v-2zm0 4h5v2H6v-2z" fill="currentColor"/></svg> <?php echo __('Background');?></div>
				<div class="collapsible-body">
					<form onsubmit="return false;" onkeypress="return event.keyCode != 13;">
						<div class="to_side_filters_innrlist">
							<h5><?php echo __('Language');?></h5>
							<div>
								<select class="_language browser-default">
									<?php
										$language = Dataset::load('language');
										$lang_html = '';
										$lang_ids = array();
										if (isset($language) && !empty($language)) {
											$all = '';
											if (!empty($data['find_match_data']) && !empty($data['find_match_data']['language']) && count($data['find_match_data']['language']) >= count($language)) {
												$all = 'selected';
											}
											elseif (!empty($data['find_match_data']) && empty($data['find_match_data']['language'])) {
												$all = 'selected';
											}
											foreach ($language as $key => $val) {
												if ($config->{$key} == 1) {
													$selected = '';
													if (!empty($data['find_match_data']) && !empty($data['find_match_data']['language']) && in_array($key, $data['find_match_data']['language']) && empty($all)) {
														$selected = 'selected';
													}
													$lang_ids[] = $key;
													$lang_html .= '<option value="' . $key . '" data-txt="' . $val . '" '.$selected.'>';
													$lang_html .= $val;
													$lang_html .= '</option>';
												}
											}
											echo '<option value="'.@implode(',', array_keys($language)) .'" data-txt="All" '.$all.'>'. __('ALL') .'</option>';
											echo $lang_html;
										}
									?>
								</select>
							</div>
						</div>
						<div class="to_side_filters_innrlist">
							<h5><?php echo __('Ethnicity');?></h5>
							<div>
								<?php
									$ethnicity = Dataset::load('ethnicity');
									if (isset($ethnicity) && !empty($ethnicity)) {
										foreach ($ethnicity as $key => $val) {
											$selected = '';
											if (!empty($data['find_match_data']) && !empty($data['find_match_data']['ethnicity']) && in_array($key, $data['find_match_data']['ethnicity'])) {
												$selected = 'checked';
											}
											echo '<p class="filtr_cbox"><label><input type="checkbox" class="_ethnicity" value="' . $key . '" data-txt="' . $val . '" '.$selected.'/><span>' . $val . '</span></label></p>';
										}
									}
								?>
							</div>
						</div>
						<div class="to_side_filters_innrlist">
							<h5><?php echo __('Religion');?></h5>
							<div>
								<?php
									$religion = Dataset::load('religion');
									if (isset($religion) && !empty($religion)) {
										foreach ($religion as $key => $val) {
											$selected = '';
											if (!empty($data['find_match_data']) && !empty($data['find_match_data']['religion']) && in_array($key, $data['find_match_data']['religion'])) {
												$selected = 'checked';
											}
											echo '<p class="filtr_cbox"><label><input type="checkbox" class="_religion" value="' . $key . '" data-txt="' . $val . '" '.$selected.'/><span>' . $val . '</span></label></p>';
										}
									}
								?>
							</div>
						</div>
						<div class="center">
							<button class="btn reset_search" type="button" id="btn_search_basic" onclick="resetSearchData()"><?php echo __('reset');?></button>
							<button class="btn btn_primary btn-find-matches-search" id="btn_search_background" type="button" disabled><?php echo __('Search');?></button>
						</div>
					</form>
				</div>
			</li>
			<li>
				<div class="collapsible-header"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path d="M13 2.05c5.053.501 9 4.765 9 9.95v1h-9v6a2 2 0 1 0 4 0v-1h2v1a4 4 0 1 1-8 0v-6H2v-1c0-5.185 3.947-9.449 9-9.95V2a1 1 0 0 1 2 0v.05zM19.938 11a8.001 8.001 0 0 0-15.876 0h15.876z" fill="currentColor"/></svg> <?php echo __('Lifestyle');?></div>
				<div class="collapsible-body">
					<form onsubmit="return false;" onkeypress="return event.keyCode != 13;">
						<div class="to_side_filters_innrlist">
							<h5><?php echo __('Status');?></h5>
							<div>
								<?php
									$relationship = Dataset::load('relationship');
									if (isset($relationship) && !empty($relationship)) {
										foreach ($relationship as $key => $val) {
											$selected = '';
											if (!empty($data['find_match_data']) && !empty($data['find_match_data']['relationship']) && in_array($key, $data['find_match_data']['relationship'])) {
												$selected = 'checked';
											}
											echo '<p class="filtr_cbox"><label><input type="checkbox" name="relationship" class="_relationship" value="' . $key . '" data-txt="' . $val . '" '.$selected.'/><span>' . $val . '</span></label></p>';
										}
									}
								?>
							</div>
						</div>
						<div class="to_side_filters_innrlist">
							<h5><?php echo __('Smokes');?></h5>
							<div>
								<?php
									$smoke = Dataset::load('smoke');
									if (isset($smoke) && !empty($smoke)) {
										foreach ($smoke as $key => $val) {
											$selected = '';
											if (!empty($data['find_match_data']) && !empty($data['find_match_data']['smoke']) && in_array($key, $data['find_match_data']['smoke'])) {
												$selected = 'checked';
											}
											echo '<p class="filtr_cbox"><label><input type="checkbox" name="smoke" class="_smoke" value="' . $key . '" data-txt="' . $val . '" '.$selected.'/><span>' . $val . '</span></label></p>';
										}
									}
								?>
							</div>
						</div>
						<div class="to_side_filters_innrlist">
							<h5><?php echo __('Drinks');?></h5>
							<div>
								<?php
									$drink = Dataset::load('drink');
									if (isset($drink) && !empty($drink)) {
										foreach ($drink as $key => $val) {
											$selected = '';
											if (!empty($data['find_match_data']) && !empty($data['find_match_data']['drink']) && in_array($key, $data['find_match_data']['drink'])) {
												$selected = 'checked';
											}
											echo '<p class="filtr_cbox"><label><input type="checkbox" name="drink" class="_drink" value="' . $key . '" data-txt="' . $val . '" '.$selected.'/><span>' . $val . '</span></label></p>';
										}
									}
								?>
							</div>
						</div>
						<div class="center">
							<button class="btn reset_search" type="button" id="btn_search_basic" onclick="resetSearchData()"><?php echo __('reset');?></button>
							<button class="btn btn_primary btn-find-matches-search" id="btn_search_lifestyle" type="button" disabled><?php echo __('Search');?></button>
						</div>
					</form>
				</div>
			</li>
			<li>
				<div class="collapsible-header"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path d="M5 10c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm14 0c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm-7 0c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z" fill="currentColor"/></svg> <?php echo __('More');?></div>
				<div class="collapsible-body">
					<form onsubmit="return false;" onkeypress="return event.keyCode != 13;">
						<div class="to_side_filters_innrlist">
							<h5><?php echo __('By Interest');?></h5>
							<div>
								<div class="input-field">
									<input placeholder="<?php echo __('e.g., Singing');?>" id="interest" type="text" class="validate" value="<?php echo(!empty($data['find_match_data']) && !empty($data['find_match_data']['interest']) ? $data['find_match_data']['interest'] : '') ?>">
									<script>
										(function() {
											document.addEventListener('DOMContentLoaded', function() {
												var _elems = document.querySelectorAll('#interest');
												var _instances = M.Autocomplete.init(_elems, {
													data: <?php echo json_encode(GetInterested());?>,
												});
											});
										})();
									</script>
								</div>
							</div>
						</div>
						<div class="to_side_filters_innrlist">
							<h5><?php echo __('Education');?></h5>
							<div>
								<?php
									$education = Dataset::load('education');
									if (isset($education) && !empty($education)) {
										foreach ($education as $key => $val) {
											$selected = '';
											if (!empty($data['find_match_data']) && !empty($data['find_match_data']['education']) && in_array($key, $data['find_match_data']['education'])) {
												$selected = 'checked';
											}
											echo '<p class="filtr_cbox"><label><input type="checkbox" name="education" class="_education" value="' . $key . '" data-txt="' . $val . '" '.$selected.'/><span>' . $val . '</span></label></p>';
										}
									}
								?>
							</div>
						</div>
						<div class="to_side_filters_innrlist">
							<h5><?php echo __('Pets');?></h5>
							<div>
								<?php
									$pets = Dataset::load('pets');
									if (isset($pets) && !empty($pets)) {
										foreach ($pets as $key => $val) {
											$selected = '';
											if (!empty($data['find_match_data']) && !empty($data['find_match_data']['pets']) && in_array($key, $data['find_match_data']['pets'])) {
												$selected = 'checked';
											}
											echo '<p class="filtr_cbox"><label><input type="checkbox" name="pets" class="_pets" value="' . $key . '" data-txt="' . $val . '" '.$selected.'/><span>' . $val . '</span></label></p>';
										}
									}
								?>
							</div>
						</div>
						<?php
							$fields = GetUserCustomFields();
							$template = $theme_path . 'partails' . $_DS . 'find-match-custom-filter.php';
							$html = '';
							if (count($fields) > 0) {
								foreach ($fields as $key => $field) {
									ob_start();
									require($template);
									$html .= ob_get_contents();
									ob_end_clean();
								}
								echo '<div>' . $html . '</div>';
								echo '<input name="custom_fields" type="hidden" value="1">';
							}
						?>
						<div class="center">
							<button class="btn reset_search" type="button" id="btn_search_basic" onclick="resetSearchData()"><?php echo __('reset');?></button>
							<button class="btn btn_primary btn-find-matches-search" id="btn_search_more" type="button" disabled><?php echo __('Search');?></button>
						</div>
					</form>
				</div>
			</li>
		</ul>
		</div>
	</div>
	<!-- End Filters  -->
</div>

<script>
$(document).ready(function(){
	$('#my_country').on('change',() => {
		//$('.located_at').html(`&nbsp;&nbsp;<?php echo __('located_at');?> <span id="located">${$("#my_country option:selected" ).text()}</span>`);
	});
	$( document ).on( 'change', '#_located', function(e){
        var valueSelected = this.value;
        //$('.located_at').html(`&nbsp;&nbsp;<?php echo __('located within');?> <span id="located">${valueSelected}</span> <?php echo $config->default_unit;?>`);
    });
	setTimeout(function () {
		$('.btn-find-matches-search').removeAttr('disabled');
	},1000);

	$( document ).on( 'change', '#is_my_location', function(e){
        if( $('#is_my_location').prop('checked') === false) {
        	$("#my_country").val('all');
        	//$('.located_at').html(`&nbsp;&nbsp;<?php echo __('located_at');?> <span id="located">${$("#my_country option:selected" ).text()}</span>`);

            $('#_located').prop("disabled", true);
            $('#_located').val( window.located );


            $('#my_country').removeAttr( 'disabled' );
            $('#my_country').prop("disabled", false);
            $('#my_country').formSelect();
            //$.get( window.ajax + 'profile/set_data', {'show_me_to': $('#my_country').attr('data-country')} );
        }else{
        	var valueSelected = $('#_located').val();
        	//$('.located_at').html(`&nbsp;&nbsp;<?php echo __('located within');?> <span id="located">${valueSelected}</span> <?php echo $config->default_unit;?>`);

            $('#_located').removeAttr( 'disabled' );
            $('#_located').val( window.located );

            $('#my_country').attr( 'disabled', 'disabled' );
            $('#my_country').prop("disabled", true);
            $('#my_country').find('option[value="'+$('#my_country').attr('data-country')+'"]').prop('selected', true);
            $('#my_country').formSelect();
            //$.get( window.ajax + 'profile/set_data', {'show_me_to': ''} );
        }
        e.preventDefault();
    });
});
function resetSearchData() {
	$.get(window.ajax + 'profile/resetSearch', function (data) {
        if (data.status == 200) {
            window.location.reload();
        }
    });
}

function Wo_ViewAnnouncement(id) {
    var announcement_container = $('.home-announcement');
	$.get(window.ajax + 'useractions/UpdateAnnouncementViews', {id:id}, function (data) {
		if (data.status == 200) {
			announcement_container.slideUp(200, function () {
				$(this).remove();
			});
		}
	});
}
</script>