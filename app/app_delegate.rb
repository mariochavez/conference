class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @storyboard ||= UIStoryboard.storyboardWithName('MainStoryboard', bundle:NSBundle.mainBundle)
    @window.rootViewController = @storyboard.instantiateInitialViewController

    @window.rootViewController.wantsFullScreenLayout = true

    seedDatabase

    @window.makeKeyAndVisible

    true
  end

  def seedDatabase
    MagicalRecord.setupCoreDataStackWithStoreNamed('database.sqlite')

    if Talk.allTalks.size == 0
      #https://github.com/Bodacious/PListReadWrite
      PListRW.copyPlistFileFromBundle(:seed)
      seed = PListRW.plistObject(:seed, Hash)

      seed['talks'].each do |key, value|
        t = Talk.createWithHash(value)
      end
    end
  end
end
