<?php global $site_url;?>
<div class="col l3 m4 s4 xs4 random_user_item" data-uid="<?php echo $random_user->id;?>">
	<div class="to_small_usr">
		<div class="border-card">
	<div class="card-image">
			<a href="<?php echo $site_url;?>/@<?php echo $random_user->username;?>" data-ajax="/@<?php echo $random_user->username;?>"><img src="<?php echo GetMedia('',false) . $random_user->avater;?>" alt="<?php echo $random_user->username;?>"></a>
			


		</div>
</div>
		<p class="text_card"><a href="<?php echo $site_url;?>/@<?php echo $random_user->username;?>" data-ajax="/@<?php echo $random_user->username;?>"><?php echo ($random_user->first_name !== '' ) ? $random_user->first_name . ' ' : $random_user->username;?></a> <?php if((int)abs(((strtotime(date('Y-m-d H:i:s')) - $random_user->lastseen))) < 60 && (int)$random_user->online == 1) { echo '<div class="useronline"></div>'; }?> <?php echo udetails_age($random_user);?></p>

    </div>
</div>