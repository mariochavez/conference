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

      presenters = []
      seed['presenters'].each do |presenter_attrs|
        presenters << Presenter.createWithHash(presenter_attrs)
      end

      seed['talks'].each do |talk_attrs|
        talk = Talk.createWithHash(talk_attrs)
        presenter = presenters.select{|p| p.presenterId == talk.presenterId }.first

        talk.presenter = presenter
        talk.save

        presenter.addTalk(talk)
        presenter.save
      end

    end
  end
end
