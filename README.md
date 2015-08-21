Gifts
====

##Test MarkDown
`

public void onCreate(Activity paramActivity) {
		context = paramActivity;
		downjoy = Downjoy.getInstance(context,
				this.sdkChannelParams.getMerchantId(),
				this.sdkChannelParams.getAppId(),
				this.sdkChannelParams.getAppSecret(),
				this.sdkChannelParams.getAppKey(), new InitListener() {

					@Override
					public void onInitComplete() {
						// TODO Auto-generated method stub

					}
				});
		downjoy.showDownjoyIconAfterLogined(true);
		downjoy.setInitLocation(Downjoy.LOCATION_RIGHT_CENTER_VERTICAL);
		downjoy.openMemberCenterDialog(context);
	}
	
`

### Test 
Learning experience
Thank you!
