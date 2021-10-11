<?php
echo '</section>'; // BodyDiv
echo '<footer class="noPrint">
		<a class="FooterLogo" href="http://www.kwamoja.com" target="_blank">
			<img src="', $RootPath, '/', $_SESSION['LogoFile'], '" width="120" alt="KwaMoja" title="KwaMoja" />
		</a>
		<div class="FooterVersion">KwaMoja ', _('version'), ' ', $_SESSION['VersionNumber'], '.', $_SESSION['DBUpdateNumber'], '</div>
		<div class="FooterTime">', DisplayDateTime(), '</div>
	</footer>'; // FooterDiv


echo '<div id="mask">
				<div id="dialog" name="dialog"></div>
			</div>';

echo '</body>';
echo '</html>';

?>