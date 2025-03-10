<?php global $db,$_LIBS; ?>
<!-- Pro Users  -->
<div class="container page-margin find_matches_cont">
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

	<div class="row r_margin">
		<div class="col l3">
			<?php require( $theme_path . 'main' . $_DS . 'sidebar.php' );?>
		</div>

		<div class="col l9">
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
			<!-- Filters  -->
			<div class="bg_gradient dt_home_filters_prnt">
				<div class="dt_home_filters">
					<div class="valign-wrapper dt_home_filters_head">
                        <p><span id="gender"><?php echo $_gender_text;?></span> <?php echo __('who ages');?> <span id="age_from"><?php echo $_age_from;?></span>-<span id="age_to"><?php echo $_age_to;?></span> <p class="located_at"> &nbsp;
                        	<?php if (!empty($data['find_match_data']) && !empty($data['find_match_data']['located'])) { ?>
                        		<?php echo __('located within');?> <span id="located"><?php echo $_located;?></span> <?php echo $config->default_unit;?>
                        	<?php }elseif (!empty($data['find_match_data']) && !empty($data['find_match_data']['country']) && !empty(Dataset::load('countries'))) {
                        		if ($data['find_match_data']['country'] == 'all') { ?>
                        			<?php echo __('located_at');?> <span id="located"><?php echo __('all_countries');?></span>
                        	<?php 	}elseif (in_array($data['find_match_data']['country'], array_keys(Dataset::load('countries')))) { ?>
                        		<?php echo __('located_at');?> <span id="located"><?php echo Dataset::load('countries')[$data['find_match_data']['country']]['name'];?></span>
                        	<?php } } ?>
                        	</p>
                        	</p>
                        	
						<button id="home_filters_toggle1" class="main_fltr">
							<span class="hide-on-small-only"><?php echo __('Apply Filters');?></span>
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M14,12V19.88C14.04,20.18 13.94,20.5 13.71,20.71C13.32,21.1 12.69,21.1 12.3,20.71L10.29,18.7C10.06,18.47 9.96,18.16 10,17.87V12H9.97L4.21,4.62C3.87,4.19 3.95,3.56 4.38,3.22C4.57,3.08 4.78,3 5,3V3H19V3C19.22,3 19.43,3.08 19.62,3.22C20.05,3.56 20.13,4.19 19.79,4.62L14.03,12H14Z" /></svg>
						</button>
						<button id="home_filters_close" class="main_fltr_close">
							<span class="hide-on-small-only"><?php echo __('Close Filters');?></span>
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M19,6.41L17.59,5L12,10.59L6.41,5L5,6.41L10.59,12L5,17.59L6.41,19L12,13.41L17.59,19L19,17.59L13.41,12L19,6.41Z" /></svg>
						</button>
					</div>
					<ul class="collapsible" id="home_filters">
						<li>
							<div class="collapsible-body filter_tabs_parent row">
								<ul class="tabs filter_tabs">
									<li class="tab">
										<a class="active" href="#basic">
											<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M5,9.5L7.5,14H2.5L5,9.5M3,4H7V8H3V4M5,20A2,2 0 0,0 7,18A2,2 0 0,0 5,16A2,2 0 0,0 3,18A2,2 0 0,0 5,20M9,5V7H21V5H9M9,19H21V17H9V19M9,13H21V11H9V13Z" /></svg> <?php echo __('Basic');?>
										</a>
									</li>
									<li class="tab">
										<a href="#looks">
											<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M9,11.75A1.25,1.25 0 0,0 7.75,13A1.25,1.25 0 0,0 9,14.25A1.25,1.25 0 0,0 10.25,13A1.25,1.25 0 0,0 9,11.75M15,11.75A1.25,1.25 0 0,0 13.75,13A1.25,1.25 0 0,0 15,14.25A1.25,1.25 0 0,0 16.25,13A1.25,1.25 0 0,0 15,11.75M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M12,20C7.59,20 4,16.41 4,12C4,11.71 4,11.42 4.05,11.14C6.41,10.09 8.28,8.16 9.26,5.77C11.07,8.33 14.05,10 17.42,10C18.2,10 18.95,9.91 19.67,9.74C19.88,10.45 20,11.21 20,12C20,16.41 16.41,20 12,20Z" /></svg> <?php echo __('Looks');?>
										</a>
									</li>
									<li class="tab">
										<a href="#background">
											<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M17.81,4.47C17.73,4.47 17.65,4.45 17.58,4.41C15.66,3.42 14,3 12,3C10.03,3 8.15,3.47 6.44,4.41C6.2,4.54 5.9,4.45 5.76,4.21C5.63,3.97 5.72,3.66 5.96,3.53C7.82,2.5 9.86,2 12,2C14.14,2 16,2.47 18.04,3.5C18.29,3.65 18.38,3.95 18.25,4.19C18.16,4.37 18,4.47 17.81,4.47M3.5,9.72C3.4,9.72 3.3,9.69 3.21,9.63C3,9.47 2.93,9.16 3.09,8.93C4.08,7.53 5.34,6.43 6.84,5.66C10,4.04 14,4.03 17.15,5.65C18.65,6.42 19.91,7.5 20.9,8.9C21.06,9.12 21,9.44 20.78,9.6C20.55,9.76 20.24,9.71 20.08,9.5C19.18,8.22 18.04,7.23 16.69,6.54C13.82,5.07 10.15,5.07 7.29,6.55C5.93,7.25 4.79,8.25 3.89,9.5C3.81,9.65 3.66,9.72 3.5,9.72M9.75,21.79C9.62,21.79 9.5,21.74 9.4,21.64C8.53,20.77 8.06,20.21 7.39,19C6.7,17.77 6.34,16.27 6.34,14.66C6.34,11.69 8.88,9.27 12,9.27C15.12,9.27 17.66,11.69 17.66,14.66A0.5,0.5 0 0,1 17.16,15.16A0.5,0.5 0 0,1 16.66,14.66C16.66,12.24 14.57,10.27 12,10.27C9.43,10.27 7.34,12.24 7.34,14.66C7.34,16.1 7.66,17.43 8.27,18.5C8.91,19.66 9.35,20.15 10.12,20.93C10.31,21.13 10.31,21.44 10.12,21.64C10,21.74 9.88,21.79 9.75,21.79M16.92,19.94C15.73,19.94 14.68,19.64 13.82,19.05C12.33,18.04 11.44,16.4 11.44,14.66A0.5,0.5 0 0,1 11.94,14.16A0.5,0.5 0 0,1 12.44,14.66C12.44,16.07 13.16,17.4 14.38,18.22C15.09,18.7 15.92,18.93 16.92,18.93C17.16,18.93 17.56,18.9 17.96,18.83C18.23,18.78 18.5,18.96 18.54,19.24C18.59,19.5 18.41,19.77 18.13,19.82C17.56,19.93 17.06,19.94 16.92,19.94M14.91,22C14.87,22 14.82,22 14.78,22C13.19,21.54 12.15,20.95 11.06,19.88C9.66,18.5 8.89,16.64 8.89,14.66C8.89,13.04 10.27,11.72 11.97,11.72C13.67,11.72 15.05,13.04 15.05,14.66C15.05,15.73 16,16.6 17.13,16.6C18.28,16.6 19.21,15.73 19.21,14.66C19.21,10.89 15.96,7.83 11.96,7.83C9.12,7.83 6.5,9.41 5.35,11.86C4.96,12.67 4.76,13.62 4.76,14.66C4.76,15.44 4.83,16.67 5.43,18.27C5.53,18.53 5.4,18.82 5.14,18.91C4.88,19 4.59,18.87 4.5,18.62C4,17.31 3.77,16 3.77,14.66C3.77,13.46 4,12.37 4.45,11.42C5.78,8.63 8.73,6.82 11.96,6.82C16.5,6.82 20.21,10.33 20.21,14.65C20.21,16.27 18.83,17.59 17.13,17.59C15.43,17.59 14.05,16.27 14.05,14.65C14.05,13.58 13.12,12.71 11.97,12.71C10.82,12.71 9.89,13.58 9.89,14.65C9.89,16.36 10.55,17.96 11.76,19.16C12.71,20.1 13.62,20.62 15.03,21C15.3,21.08 15.45,21.36 15.38,21.62C15.33,21.85 15.12,22 14.91,22Z" /></svg> <?php echo __('Background');?>
										</a>
									</li>
									<li class="tab">
										<a href="#lifestyle">
											<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M15,18.54C17.13,18.21 19.5,18 22,18V22H5C5,21.35 8.2,19.86 13,18.9V12.4C12.16,12.65 11.45,13.21 11,13.95C10.39,12.93 9.27,12.25 8,12.25C6.73,12.25 5.61,12.93 5,13.95C5.03,10.37 8.5,7.43 13,7.04V7A1,1 0 0,1 14,6A1,1 0 0,1 15,7V7.04C19.5,7.43 22.96,10.37 23,13.95C22.39,12.93 21.27,12.25 20,12.25C18.73,12.25 17.61,12.93 17,13.95C16.55,13.21 15.84,12.65 15,12.39V18.54M7,2A5,5 0 0,1 2,7V2H7Z" /></svg> <?php echo __('Lifestyle');?>
										</a>
									</li>
									<li class="tab">
										<a href="#tab_more">
											<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M16,12A2,2 0 0,1 18,10A2,2 0 0,1 20,12A2,2 0 0,1 18,14A2,2 0 0,1 16,12M10,12A2,2 0 0,1 12,10A2,2 0 0,1 14,12A2,2 0 0,1 12,14A2,2 0 0,1 10,12M4,12A2,2 0 0,1 6,10A2,2 0 0,1 8,12A2,2 0 0,1 6,14A2,2 0 0,1 4,12Z" /></svg> <?php echo __('More');?>
										</a>
									</li>
								</ul>
								<div id="basic" class="col s12 active search_filters">
									<form onsubmit="return false;" onkeypress="return event.keyCode != 13;">
										<div class="row">
											<div class="col s12 m2">
												<h5><?php echo __('Gender');?></h5>
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
															echo '<p><label><input type="checkbox" class="_gender filled-in" value="' . $key . '" data-txt="' . $val . '" '.$_checked.'  data-vx="' . $key . '"/><span  class="_gender_text" data-txt="' . $val . '">' . $val . '</span></label></p>';
														}
													}
													if (empty($_gender)) {
														$all_checked = 'checked';
													}
												?>
												<p><label><input type="checkbox" class="_gender filled-in" value="<?php echo implode(",",$all_gender);?>" data-vx="_all_" data-txt="<?php echo __('All');?>" <?php echo $all_checked;?> /><span class="_gender_text" data-txt="<?php echo __('All');?>"><?php echo __('All');?></span></label></p>
											</div>
                                            <?php if($config->filter_by_country == 'ALL' || ($config->filter_by_country == 'PRO' && ($profile->is_pro == 1 || $config->pro_system == 0))){
                                            $active_show_me_to = $profile->show_me_to;
                                            ?>
											<div class="col s12 m4">
												<div class="valign-wrapper dt_hm_filtr_loc">
													<label title="<?php echo __('My location');?>">
														<input type="checkbox" class="filled-in" <?php if(!empty($data['find_match_data']) && !empty($data['find_match_data']['located'])){ ?>checked="checked"<?php }?> id="is_my_location">
														<b><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M12,11.5A2.5,2.5 0 0,1 9.5,9A2.5,2.5 0 0,1 12,6.5A2.5,2.5 0 0,1 14.5,9A2.5,2.5 0 0,1 12,11.5M12,2A7,7 0 0,0 5,9C5,14.25 12,22 12,22C12,22 19,14.25 19,9A7,7 0 0,0 12,2Z" /></svg></b>
													</label>
													<select id="my_country" name="my_country" data-country="<?php echo $profile->country;?>" <?php if(!empty($data['find_match_data']) && !empty($data['find_match_data']['located'])) {?>disabled="disabled"<?php }?>  <?php if($config->filter_by_cities == 1 && !empty($config->geo_username)){ ?>onchange="ChangeCountryKey(this)"<?php } ?>>
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
												</div>
                                                <?php if ($config->filter_by_cities == 1 && !empty($config->geo_username)) { ?>
													<div style="position: relative;margin-top: 10px;">
														<input type="hidden" class="city_country_key" name="city_country_key" value="<?php echo($city_country_key); ?>">
														<input type="text" name="city" placeholder="<?php echo __( 'City' );?>" <?php if($config->filter_by_cities == 1 && !empty($config->geo_username)){ ?>onkeyup="SearchForCity(this)"<?php } ?> class="selected_city" value="<?php echo(!empty($data['find_match_data']) && !empty($data['find_match_data']['city']) ? $data['find_match_data']['city'] : '') ?>">
														<div class="city_search_result"></div>
													</div>
                                                <?php } ?>
											</div>
                                            <?php } ?>
											<div class="col s12 m3">
												<h5><?php echo __('Ages');?></h5>
												<div class="row r_margin">
													<div class="input-field col s6">
														<select class="_age_from">
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
														<select class="_age_to">
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
											<div class="col s12 m3">
												<h5><?php echo __('Distance');?></h5>
												<p class="range-field">
                                                    <input type="range" min="1" max="250" value="<?php echo !empty($data['find_match_data']) && !empty($data['find_match_data']['located']) ? $data['find_match_data']['located'] : 125 ;?>" id="_located" <?php if(!empty($data['find_match_data']) && empty($data['find_match_data']['located'])) {?>disabled="disabled"<?php }?> style="direction: ltr!important;"/>
												</p>
											</div>
										</div>
										<input type="hidden" id="_lat" value="<?php echo $profile->lat;?>">
										<input type="hidden" id="_lng" value="<?php echo $profile->lng;?>">
										<div class="btn_wrapper valign-wrapper">
											<button class="btn waves-effect btn_glossy btn-flat btn-large waves-light reset_search" type="button" id="btn_search_basic" onclick="resetSearchData()"><?php echo __('reset');?></button>
											<button class="btn waves-effect btn_glossy btn-flat btn-large waves-light btn-find-matches-search" type="button" id="btn_search_basic" disabled><?php echo __('Search');?></button>
										</div>
									</form>
								</div>
								<div id="looks" class="col s12 search_filters" style="display: none;">
									<form onsubmit="return false;" onkeypress="return event.keyCode != 13;">
										<div class="row">
											<div class="col s12 m5">
												<h5><?php echo __('Height');?></h5>
												<div class="input-field col s6">
                                                    <select class="height_from">
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
                                                    <select class="height_to">
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
											<div class="col s12 m1"></div>
											<div class="col s12 m6">
												<h5><?php echo __('Body type');?></h5>
												<?php
													$body = Dataset::load('body');
													if (isset($body) && !empty($body)) {
														foreach ($body as $key => $val) {
															$selected = '';
										if (!empty($data['find_match_data']) && !empty($data['find_match_data']['body']) && in_array($key, $data['find_match_data']['body'])) {
											$selected = 'checked';
										}
															echo '<p class="col s6 m3"><label><input type="checkbox" class="_body filled-in" value="' . $key . '" data-txt="' . $val . '" '.$selected.'/><span>' . $val . '</span></label></p>';
														}
													}
												?>
											</div>
										</div>
										<div class="btn_wrapper valign-wrapper">
											<button class="btn waves-effect btn_glossy btn-flat btn-large waves-light reset_search" type="button" id="btn_search_basic" onclick="resetSearchData()"><?php echo __('reset');?></button>
											<button class="btn waves-effect btn_glossy btn-flat btn-large waves-light btn-find-matches-search" id="btn_search_looks" type="button" disabled><?php echo __('Search');?></button>
										</div>
									</form>
								</div>
								<div id="background" class="col s12 search_filters" style="display: none;">
									<form onsubmit="return false;" onkeypress="return event.keyCode != 13;">
										<div class="row">
											<div class="col s12 m4">
												<h5><?php echo __('Language');?></h5>
												<div class="input-field col s12">
													<select class="_language">
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
											<div class="col s12 m4">
												<h5><?php echo __('Ethnicity');?></h5>
												<?php
													$ethnicity = Dataset::load('ethnicity');
													if (isset($ethnicity) && !empty($ethnicity)) {
														foreach ($ethnicity as $key => $val) {
															$selected = '';
										if (!empty($data['find_match_data']) && !empty($data['find_match_data']['ethnicity']) && in_array($key, $data['find_match_data']['ethnicity'])) {
											$selected = 'checked';
										}
															echo '<p class="col s6"><label><input type="checkbox" class="_ethnicity filled-in" value="' . $key . '" data-txt="' . $val . '" '.$selected.'/><span>' . $val . '</span></label></p>';
														}
													}
												?>
											</div>
											<div class="col s12 m4">
												<h5><?php echo __('Religion');?></h5>
												<?php
													$religion = Dataset::load('religion');
													if (isset($religion) && !empty($religion)) {
														foreach ($religion as $key => $val) {
															$selected = '';
										if (!empty($data['find_match_data']) && !empty($data['find_match_data']['religion']) && in_array($key, $data['find_match_data']['religion'])) {
											$selected = 'checked';
										}
															echo '<p class="col s6"><label><input type="checkbox" class="_religion filled-in" value="' . $key . '" data-txt="' . $val . '" '.$selected.'/><span>' . $val . '</span></label></p>';
														}
													}
												?>
											</div>
										</div>
										<div class="btn_wrapper valign-wrapper">
											<button class="btn waves-effect btn_glossy btn-flat btn-large waves-light reset_search" type="button" id="btn_search_basic" onclick="resetSearchData()"><?php echo __('reset');?></button>
											<button class="btn waves-effect btn_glossy btn-flat btn-large waves-light btn-find-matches-search" id="btn_search_background" type="button" disabled><?php echo __('Search');?></button>
										</div>
									</form>
								</div>
								<div id="lifestyle" class="col s12 search_filters" style="display: none;">
									<form onsubmit="return false;" onkeypress="return event.keyCode != 13;">
										<div class="row">
											<div class="col s12 m2">
												<h5><?php echo __('Status');?></h5>
												<?php
													$relationship = Dataset::load('relationship');
													if (isset($relationship) && !empty($relationship)) {
														foreach ($relationship as $key => $val) {
															$selected = '';
										if (!empty($data['find_match_data']) && !empty($data['find_match_data']['relationship']) && in_array($key, $data['find_match_data']['relationship'])) {
											$selected = 'checked';
										}
															echo '<p class="col s6 m12"><label><input type="checkbox" name="relationship" class="_relationship filled-in" value="' . $key . '" data-txt="' . $val . '" '.$selected.'/><span>' . $val . '</span></label></p>';
														}
													}
												?>
											</div>
											<div class="col s12 m3">
												<h5><?php echo __('Smokes');?></h5>
												<?php
													$smoke = Dataset::load('smoke');
													if (isset($smoke) && !empty($smoke)) {
														foreach ($smoke as $key => $val) {
															$selected = '';
										if (!empty($data['find_match_data']) && !empty($data['find_match_data']['smoke']) && in_array($key, $data['find_match_data']['smoke'])) {
											$selected = 'checked';
										}
															echo '<p class="col s6 m12"><label><input type="checkbox" name="smoke" class="_smoke filled-in" value="' . $key . '" data-txt="' . $val . '" '.$selected.'/><span>' . $val . '</span></label></p>';
														}
													}
												?>
											</div>
											<div class="col s12 m7">
												<h5><?php echo __('Drinks');?></h5>
												<?php
													$drink = Dataset::load('drink');
													if (isset($drink) && !empty($drink)) {
														foreach ($drink as $key => $val) {
															$selected = '';
										if (!empty($data['find_match_data']) && !empty($data['find_match_data']['drink']) && in_array($key, $data['find_match_data']['drink'])) {
											$selected = 'checked';
										}
															echo '<p class="col s6 m12"><label><input type="checkbox" name="drink" class="_drink filled-in" value="' . $key . '" data-txt="' . $val . '" '.$selected.'/><span>' . $val . '</span></label></p>';
														}
													}
												?>
											</div>
										</div>
										<div class="btn_wrapper valign-wrapper">
											<button class="btn waves-effect btn_glossy btn-flat btn-large waves-light reset_search" type="button" id="btn_search_basic" onclick="resetSearchData()"><?php echo __('reset');?></button>
											<button class="btn waves-effect btn_glossy btn-flat btn-large waves-light btn-find-matches-search" id="btn_search_lifestyle" type="button" disabled><?php echo __('Search');?></button>
										</div>
									</form>
								</div>
								<div id="tab_more" class="col s12 search_filters" style="display: none;">
									<form onsubmit="return false;" onkeypress="return event.keyCode != 13;">
										<div class="row">
											<div class="col s12 m4">
												<h5><?php echo __('By Interest');?></h5>
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
											<div class="col s12 m5">
												<h5><?php echo __('Education');?></h5>
												<?php
													$education = Dataset::load('education');
													if (isset($education) && !empty($education)) {
														foreach ($education as $key => $val) {
															$selected = '';
										if (!empty($data['find_match_data']) && !empty($data['find_match_data']['education']) && in_array($key, $data['find_match_data']['education'])) {
											$selected = 'checked';
										}
															echo '<p class="col s6"><label><input type="checkbox" name="education" class="_education filled-in" value="' . $key . '" data-txt="' . $val . '" '.$selected.'/><span>' . $val . '</span></label></p>';
														}
													}
												?>
											</div>
											<div class="col s12 m3">
												<h5><?php echo __('Pets');?></h5>
												<?php
													$pets = Dataset::load('pets');
													if (isset($pets) && !empty($pets)) {
														foreach ($pets as $key => $val) {
															$selected = '';
										if (!empty($data['find_match_data']) && !empty($data['find_match_data']['pets']) && in_array($key, $data['find_match_data']['pets'])) {
											$selected = 'checked';
										}
															echo '<p class="col s6 m12"><label><input type="checkbox" name="pets" class="_pets filled-in" value="' . $key . '" data-txt="' . $val . '" '.$selected.'/><span>' . $val . '</span></label></p>';
														}
													}
												?>
											</div>
										</div>


                                        <?php
                                        $fields = GetUserCustomFields();
                                        $template = $theme_path . 'partails' . $_DS . 'profile-fields-search.php';
                                        $html = '';
                                        if (count($fields) > 0) {
                                            foreach ($fields as $key => $field) {
                                                ob_start();
                                                require($template);
                                                $html .= ob_get_contents();
                                                ob_end_clean();
                                            }
                                            echo '<div class="row">' . $html . '</div>';
                                            echo '<input name="custom_fields" type="hidden" value="1">';
                                        }
                                        ?>

										<div class="btn_wrapper valign-wrapper">
											<button class="btn waves-effect btn_glossy btn-flat btn-large waves-light reset_search" type="button" id="btn_search_basic" onclick="resetSearchData()"><?php echo __('reset');?></button>
											<button class="btn waves-effect btn_glossy btn-flat btn-large waves-light btn-find-matches-search" id="btn_search_more" type="button" disabled><?php echo __('Search');?></button>
										</div>
									</form>
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
			<!-- End Filters  -->

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
//                if($count_swipe_for_this_day >= $max_swaps) {
//                    $warning_style='';
//                    $match_style='hide';
//                }else{
//                    $warning_style='hide';
//                    $match_style='';
//                }
            ?>

            <!--<h5 id="max_swipes_reached" class="empty_state <?php echo $warning_style;?>">
                <svg height="512pt" viewBox="0 0 512 512" width="512pt" xmlns="http://www.w3.org/2000/svg"><path d="m452 40h-24v-40h-40v40h-264v-40h-40v40h-24c-33.085938 0-60 26.914062-60 60v352c0 33.085938 26.914062 60 60 60h392c33.085938 0 60-26.914062 60-60v-352c0-33.085938-26.914062-60-60-60zm-392 40h24v40h40v-40h264v40h40v-40h24c11.027344 0 20 8.972656 20 20v48h-432v-48c0-11.027344 8.972656-20 20-20zm392 392h-392c-11.027344 0-20-8.972656-20-20v-264h432v264c0 11.027344-8.972656 20-20 20zm-216-245h40v125h-40zm0 165h40v40h-40zm0 0"/></svg>
                <p id="w_message"><?php echo str_replace('{0}',$raminhours, __('You reach the max of swipes per day. you have to wait {0} hours before you can redo likes Or upgrade to pro to for unlimited.') );?></p>
            </h5>-->

            <!-- Match Users  -->
            <div id="section_match_users" class="<?php echo $match_style;?>">
                <?php
                if (empty($data['matches'])) {
                    echo '<h5 id="_load_more" class="empty_state"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M9,4A4,4 0 0,1 13,8A4,4 0 0,1 9,12A4,4 0 0,1 5,8A4,4 0 0,1 9,4M9,6A2,2 0 0,0 7,8A2,2 0 0,0 9,10A2,2 0 0,0 11,8A2,2 0 0,0 9,6M9,13C11.67,13 17,14.34 17,17V20H1V17C1,14.34 6.33,13 9,13M9,14.9C6.03,14.9 2.9,16.36 2.9,17V18.1H15.1V17C15.1,16.36 11.97,14.9 9,14.9M15,4A4,4 0 0,1 19,8A4,4 0 0,1 15,12C14.53,12 14.08,11.92 13.67,11.77C14.5,10.74 15,9.43 15,8C15,6.57 14.5,5.26 13.67,4.23C14.08,4.08 14.53,4 15,4M23,17V20H19V16.5C19,15.25 18.24,14.1 16.97,13.18C19.68,13.62 23,14.9 23,17Z"></path></svg>' . __('view_no_more_to_show') . '</h5>';
                } else {
                    ?>
                    <div class="valign-wrapper dt_home_match_user">
                        <div class="mtc_usr_avtr" id="avaters_item_container">
                            <?php echo $data['matches_img']; ?>
                        </div>
                        <div class="mtc_usr_details" id="match_item_container">
                            <?php echo $data['matches']; ?>
                        </div>
                    </div>
                <?php } ?>
            </div>





			<a href="javascript:void(0);" style="display: none;" id="btn_load_more_match_users" data-lang-loadmore="<?php echo __('Load more...');?>" data-lang-nomore="<?php echo __('No more users to show.');?>" data-ajax-post="/loadmore/match_users" data-ajax-params="page=2" data-ajax-callback="callback_load_more_match_users" class="btn waves-effect load_more"><?php echo __('Load more...');?></a>
			<!-- End Match Users  -->

			<!-- Random Users  -->
            <?php if(!empty($data['random_users'])){ ?>
			<div class="dt_ltst_users" id="dt_ltst_users">
				<div class="dt_home_rand_user">
					<h4 class="bold"><div><svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24"><path fill="currentColor" d="M16,13C15.71,13 15.38,13 15.03,13.05C16.19,13.89 17,15 17,16.5V19H23V16.5C23,14.17 18.33,13 16,13M8,13C5.67,13 1,14.17 1,16.5V19H15V16.5C15,14.17 10.33,13 8,13M8,11A3,3 0 0,0 11,8A3,3 0 0,0 8,5A3,3 0 0,0 5,8A3,3 0 0,0 8,11M16,11A3,3 0 0,0 19,8A3,3 0 0,0 16,5A3,3 0 0,0 13,8A3,3 0 0,0 16,11Z"></path></svg></div> <?php echo __( 'Random Users' );?></h4>
					<div class="row" id="random_users_container">
                        <?php echo $data['random_users']; ?>
					</div>
                    <?php if(!empty($data['random_users'])){ ?>
					<a href="javascript:void(0);" id="btn_load_more_random_users" data-lang-nomore="<?php echo __('No more users to show.');?>" data-ajax-post="/loadmore/random_users" data-ajax-params="page=2" data-ajax-callback="callback_load_more_random_users" class="btn waves-effect load_more"><?php echo __('Load more...');?></a>
                    <?php } ?>
                </div>
			</div>
            <?php } ?>
			<!-- End Random Users  -->

			<!-- Search Users  -->
			<div class="dt_ltst_users hide" id="latest_user">
				<div class="dt_home_rand_user">
					<div class="row" id="search_users_container">

					</div>
					<a href="javascript:void(0);" id="btn_load_more_search_users" data-lang-more="<?php echo __('Load more...');?>" data-lang-nomore="<?php echo __('view_no_more_to_show');?>" data-ajax-post="/loadmore/find_matches" data-ajax-params="page=2" data-ajax-callback="callback_load_more_search_users" class="btn waves-effect load_more hide"><?php echo __('Load more...');?></a>
				</div>
			</div>
		</div>
		<!-- End Search Users  -->
	</div>
</div>
<script>
$(document).ready(function(){
	$('#my_country').on('change',() => {
		$('.located_at').html(`&nbsp;&nbsp;<?php echo __('located_at');?> <span id="located">${$("#my_country option:selected" ).text()}</span>`);
	});
	$( document ).on( 'change', '#_located', function(e){
        var valueSelected = this.value;
        $('.located_at').html(`&nbsp;&nbsp;<?php echo __('located within');?> <span id="located">${valueSelected}</span> <?php echo $config->default_unit;?>`);
    });
	setTimeout(function () {
		$('.btn-find-matches-search').removeAttr('disabled');
	},1000);

	$( document ).on( 'change', '#is_my_location', function(e){
        if( $('#is_my_location').prop('checked') === false) {
        	$("#my_country").val('all');
        	$('.located_at').html(`&nbsp;&nbsp;<?php echo __('located_at');?> <span id="located">${$("#my_country option:selected" ).text()}</span>`);

            $('#_located').prop("disabled", true);
            $('#_located').val( window.located );


            $('#my_country').removeAttr( 'disabled' );
            $('#my_country').prop("disabled", false);
            $('#my_country').formSelect();
            //$.get( window.ajax + 'profile/set_data', {'show_me_to': $('#my_country').attr('data-country')} );
        }else{
        	var valueSelected = $('#_located').val();
        	$('.located_at').html(`&nbsp;&nbsp;<?php echo __('located within');?> <span id="located">${valueSelected}</span> <?php echo $config->default_unit;?>`);

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