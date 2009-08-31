package com.collectivecolors.emvc.patterns.observer
{
  //----------------------------------------------------------------------------
  // Imports
  
  import com.collectivecolors.emvc.interfaces.IExtensibleFacade;
  import com.collectivecolors.emvc.patterns.facade.ExtensibleFacade;
  
  import org.puremvc.as3.interfaces.INotifier;

  //----------------------------------------------------------------------------

  public class ExtensibleNotifier implements INotifier
  {
    //--------------------------------------------------------------------------
    // Properties
    
    // Local reference to the ExtensibleFacade Singleton
    protected static var core : IExtensibleFacade = ExtensibleFacade.getInstance( );
    
    //--------------------------------------------------------------------------
    // Notifier methods

    /**
		 * Create and send an <code>INotification</code>.
		 * 
		 * <P>
		 * Keeps us from having to construct new INotification 
		 * instances in our implementation code.
		 * @param notificationName the name of the notiification to send
		 * @param body the body of the notification (optional)
		 * @param type the type of the notification (optional)
		 */
    public function sendNotification( noteName : String, 
                                      body : Object = null, 
                                      type : String = null ) : void
    {
      core.sendNotification( noteName, body, type );
    }    
  }
}