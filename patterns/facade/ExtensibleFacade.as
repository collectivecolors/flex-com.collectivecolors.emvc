package com.collectivecolors.emvc.patterns.facade
{
  //----------------------------------------------------------------------------
  // Imports
  
  import com.collectivecolors.emvc.core.Manager;
  import com.collectivecolors.emvc.interfaces.IExtensibleFacade;
  import com.collectivecolors.emvc.interfaces.IExtension;
  import com.collectivecolors.emvc.interfaces.IManager;
  import com.collectivecolors.mcmvc.patterns.facade.MultiCommandFacade;
  
  import org.puremvc.as3.interfaces.IMediator;
  import org.puremvc.as3.interfaces.INotification;
  import org.puremvc.as3.interfaces.IProxy;
  
  //----------------------------------------------------------------------------
  
  public class ExtensibleFacade extends MultiCommandFacade implements IExtensibleFacade
  {
    //--------------------------------------------------------------------------
    // Constants
    
    //----------------
    // Notifications
    
    public static const STARTUP : String  = "startupNotification";
    public static const SHUTDOWN : String = "shutdownNotification";
    
    //--------------------------------------------------------------------------
		// Properties

		protected var manager : IManager;		
		
    //--------------------------------------------------------------------------
    // Constructor
    
		/**
		 * ExtensibleFacade Singleton Factory method
		 * 
		 * @return the Singleton instance of the ExtensibleFacade
		 */
		public static function getInstance( ) : IExtensibleFacade 
		{
			if ( instance == null ) instance = new ExtensibleFacade( );
			return instance as IExtensibleFacade;
		}
		
		//--------------------------------------------------------------------------
		// Initialization

    /**
		 * Initialize the Singleton <code>ExtensibleFacade</code> instance.
		 * 
		 * <P>
		 * Called automatically by the constructor. Override in your
		 * subclass to do any subclass specific initializations. Be
		 * sure to call <code>super.initializeFacade()</code>, though.</P>
		 */
		override protected function initializeFacade( ) : void 
		{
		  // Allow application and sub facades to register required extensions.
		  initializeManager( );
		  
		  // Initialize PureMVC components.
			super.initializeFacade( );			
		}

		/**
		 * Initialize the <code>Manager</code>.
		 * 
		 * <P>
		 * Called by the <code>initializeFacade</code> method.
		 * Override this method in your subclass of <code>ExtensibleFacade</code> 
		 * if one or both of the following are true:
		 * <UL>
		 * <LI> You wish to initialize a different <code>IManager</code>.</LI>
		 * <LI> You have <code>Extension</code>s to register with the Manager that do not 
		 * retrieve a reference to the ExtensibleFacade at construction time.</code></LI> 
		 * </UL>
		 * If you don't want to initialize a different <code>IManager</code>, 
		 * call <code>super.initializeManager()</code> at the beginning of your
		 * method, then register <code>Extension</code>s.
		 */
		protected function initializeManager( ) : void 
		{
			if ( manager != null ) return;
			manager = Manager.getInstance( );
		}
		
		/**
		 * Initialize the <code>Controller</code>.
		 * 
		 * <P>
		 * Called by the <code>initializeFacade</code> method.
		 * Override this method in your subclass of <code>ExtensibleFacade</code> 
		 * if one or both of the following are true:
		 * <UL>
		 * <LI> You wish to initialize a different <code>IController</code>.</LI>
		 * <LI> You have <code>Commands</code> to register with the <code>Controller</code> at startup.</code>. </LI>		  
		 * </UL>
		 * If you don't want to initialize a different <code>IController</code>, 
		 * call <code>super.initializeController()</code> at the beginning of your
		 * method, then register <code>Command</code>s.
		 * </P>
		 */
		override protected function initializeController( ) : void 
		{
			super.initializeController( );
			
			// Allow registered extensions to register their own commands.
			executeMethod( 'initializeController' );
		}
    
		/**
		 * Initialize the <code>Model</code>.
		 * 
		 * <P>
		 * Called by the <code>initializeFacade</code> method.
		 * Override this method in your subclass of <code>ExtensibleFacade</code> 
		 * if one or both of the following are true:
		 * <UL>
		 * <LI> You wish to initialize a different <code>IModel</code>.</LI>
		 * <LI> You have <code>Proxy</code>s to register with the Model that do not 
		 * retrieve a reference to the Facade at construction time.</code></LI> 
		 * </UL>
		 * If you don't want to initialize a different <code>IModel</code>, 
		 * call <code>super.initializeModel()</code> at the beginning of your
		 * method, then register <code>Proxy</code>s.
		 * <P>
		 * Note: This method is <i>rarely</i> overridden; in practice you are more
		 * likely to use a <code>Command</code> to create and register <code>Proxy</code>s
		 * with the <code>Model</code>, since <code>Proxy</code>s with mutable data will likely
		 * need to send <code>INotification</code>s and thus will likely want to fetch a reference to 
		 * the <code>ExtensibleFacade</code> during their construction. 
		 * </P>
		 */
		override protected function initializeModel( ) : void 
		{
			super.initializeModel( );
			
			// Allow registered extensions to register their own proxies.
			executeMethod( 'initializeModel' );
		}
		
		/**
		 * Initialize the <code>View</code>.
		 * 
		 * <P>
		 * Called by the <code>initializeFacade</code> method.
		 * Override this method in your subclass of <code>ExtensibleFacade</code> 
		 * if one or both of the following are true:
		 * <UL>
		 * <LI> You wish to initialize a different <code>IView</code>.</LI>
		 * <LI> You have <code>Observers</code> to register with the <code>View</code></LI>
		 * </UL>
		 * If you don't want to initialize a different <code>IView</code>, 
		 * call <code>super.initializeView()</code> at the beginning of your
		 * method, then register <code>IMediator</code> instances.
		 * <P>
		 * Note: This method is <i>rarely</i> overridden; in practice you are more
		 * likely to use a <code>Command</code> to create and register <code>Mediator</code>s
		 * with the <code>View</code>, since <code>IMediator</code> instances will need to send 
		 * <code>INotification</code>s and thus will likely want to fetch a reference 
		 * to the <code>ExtensibleFacade</code> during their construction. 
		 * </P>
		 */
		override protected function initializeView( ) : void 
		{
			super.initializeView( );
			
			// Allow registered extensions to register their own mediators.
			executeMethod( 'initializeView' );
		}
		
		/**
		 * Main application startup method.
		 * 
		 * @param application the application object
		 */
		public function startup( application : Object ) : void
		{
		  sendNotification( STARTUP, application );
		}
		
		/**
		 * Main application shutdown method.
		 */
		public function shutdown( ) : void
		{
		  sendNotification( SHUTDOWN );
		}
		
		//--------------------------------------------------------------------------
		// Extension methods
		
		/**
		 * List all registered <code>IExtension</code> instances.
		 * 
		 * @return array containing all registered <code>IExtension</code> instances.
		 */
		public function listExtensions( ) : Array
		{
		  return manager.listExtensions( );
		}
		
		/**
		 * Register an <code>IExtension</code> with the <code>Manager</code> by name.
		 * 
		 * @param extension the <code>IExtension</code> instance to be registered with the <code>Manager</code>.
		 */
		public function registerExtension( extension : IExtension ) : void	
		{
			removeExtension( extension.getExtensionName( ) );
			
			manager.registerExtension( extension );
			executeMethod( 'registerExtension', extension );	
		}
				
		/**
		 * Retrieve an <code>IExtension</code> from the <code>Manager</code> by name.
		 * 
		 * @param extensionName the name of the extension to be retrieved.
		 * @return the <code>IExtension</code> instance previously registered with the given <code>extensionName</code>.
		 */
		public function retrieveExtension( extensionName : String ) : IExtension 
		{
			var extension : IExtension = manager.retrieveExtension( extensionName ); 
			
			executeMethod( 'retrieveExtension', extensionName, extension );
			
			return extension;	
		}

		/**
		 * Remove an <code>IExtension</code> from the <code>Manager</code> by name.
		 *
		 * @param extensionName the <code>IExtension</code> to remove from the <code>Manager</code>.
		 * @return the <code>IExtension</code> that was removed from the <code>Manager</code>
		 */
		public function removeExtension( extensionName : String ) : IExtension 
		{
			var extension : IExtension = manager.removeExtension( extensionName );
			
			if ( extension )
			{
			  executeMethod( 'removeExtension', extension );
			}
			
			return extension;
		}

		/**
		 * Check if a <code>Extension</code> is registered
		 * 
		 * @param extensionName the <code>IExtension</code> to check for in the <code>Manager</code>.
		 * @return whether a <code>Extension</code> is currently registered with the given <code>extensionName</code>.
		 */
		public function hasExtension( extensionName : String ) : Boolean
		{
			return manager.hasExtension( extensionName );
		}
				
		/**
		 * Invoke a method on all registered <code>IExtension</code> instances.
		 * 
		 * @param methodName the method name to call in a registered <code>IExtension</code>.
		 * @param args whatever arguments that this method provides.
		 * @return whatever value that this method returns.
		 */
		public function executeMethod( methodName : String, ... args ) : *
    {
      return manager.executeMethod( methodName, args );  
    }
		
		/**
		 * Invoke a method on all registered <code>IExtension</code> instances.
		 * 
		 * @param methodName the method name to call in a registered <code>IExtension</code>.
		 * @param args whatever arguments that this method provides.
		 * @return whatever value that this method returns.
		 */
		public function executeContextMethod( contextName : String, 
		                                      methodName : String, 
		                                      ... args ) : *
		{
		  return manager.executeContextMethod( contextName, methodName, args );
		}
		
		//--------------------------------------------------------------------------
		// Controller methods
		
		/**
		 * Register an <code>ICommand</code> with the <code>Controller</code> by Notification name.
		 * 
		 * @param notificationName the name of the <code>INotification</code> to associate the <code>ICommand</code> with
		 * @param commandClassRef a reference to the Class of the <code>ICommand</code>
		 */
		override public function registerCommand( noteName : String, commandClassRef : Class ) : void 
		{
			super.registerCommand( noteName, commandClassRef );			
			executeMethod( 'registerCommand', noteName, commandClassRef );
		}
		
		/**
		 * Remove a previously registered <code>ICommand</code> to <code>INotification</code> mapping from the Controller.
		 * 
		 * @param notificationName the name of the <code>INotification</code> to remove the <code>ICommand</code> mapping for
		 */
		override public function removeCommand( noteName : String ) : void 
		{
			super.removeCommand( noteName );
			executeMethod( 'removeCommand', noteName );
		}
		
		/**
		 * Remove a previously registered <code>ICommand</code> to <code>INotification</code> mapping.
		 * 
		 * @param noteName the name of the <code>INotification</code> to remove the <code>ICommand</code> mapping for
		 * @param commandClassRef class reference to <code>ICommand</code> to remove
		 */
    override public function removeCommandClass( noteName : String, 
                                                 commandClassRef : Class ) : void
    {
      super.removeCommandClass( noteName, commandClassRef );
      executeMethod( 'removeCommand', noteName, commandClassRef );  
    }    
    
		//--------------------------------------------------------------------------
		// Model methods
		
		/**
		 * Register an <code>IProxy</code> with the <code>Model</code> by name.
		 * 
		 * @param proxyName the name of the <code>IProxy</code>.
		 * @param proxy the <code>IProxy</code> instance to be registered with the <code>Model</code>.
		 */
		override public function registerProxy( proxy : IProxy ) : void	
		{
			removeProxy( proxy.getProxyName( ) );
			
			super.registerProxy( proxy );
			executeMethod( 'registerProxy', proxy );	
		}
				
		/**
		 * Retrieve an <code>IProxy</code> from the <code>Model</code> by name.
		 * 
		 * @param proxyName the name of the proxy to be retrieved.
		 * @return the <code>IProxy</code> instance previously registered with the given <code>proxyName</code>.
		 */
		override public function retrieveProxy( proxyName : String ) : IProxy 
		{
			var proxy : IProxy = super.retrieveProxy( proxyName );
			
			executeMethod( 'retrieveProxy', proxyName, proxy );
			
			return proxy;	
		}

		/**
		 * Remove an <code>IProxy</code> from the <code>Model</code> by name.
		 *
		 * @param proxyName the <code>IProxy</code> to remove from the <code>Model</code>.
		 * @return the <code>IProxy</code> that was removed from the <code>Model</code>
		 */
		override public function removeProxy( proxyName : String ) : IProxy 
		{
			var proxy : IProxy = super.removeProxy( proxyName );	
			
			if ( proxy )
			{
			  executeMethod( 'removeProxy', proxy );
			}
			
			return proxy
		}

		//--------------------------------------------------------------------------
		// View methods
		
		/**
		 * Register a <code>IMediator</code> with the <code>View</code>.
		 * 
		 * @param mediatorName the name to associate with this <code>IMediator</code>
		 * @param mediator a reference to the <code>IMediator</code>
		 */
		override public function registerMediator( mediator : IMediator ) : void 
		{
			removeMediator( mediator.getMediatorName( ) );
			
			super.registerMediator( mediator );
			executeMethod( 'registerMediator', mediator );
		}

		/**
		 * Retrieve an <code>IMediator</code> from the <code>View</code>.
		 * 
		 * @param mediatorName
		 * @return the <code>IMediator</code> previously registered with the given <code>mediatorName</code>.
		 */
		override public function retrieveMediator( mediatorName : String ) : IMediator 
		{
			var mediator : IMediator = super.retrieveMediator( mediatorName );
			
			executeMethod( 'retrieveMediator', mediatorName, mediator );
			
			return mediator;
		}

		/**
		 * Remove an <code>IMediator</code> from the <code>View</code>.
		 * 
		 * @param mediatorName name of the <code>IMediator</code> to be removed.
		 * @return the <code>IMediator</code> that was removed from the <code>View</code>
		 */
		override public function removeMediator( mediatorName : String ) : IMediator 
		{
			var mediator : IMediator = super.removeMediator( mediatorName );
			
			if ( mediator )
			{
			  executeMethod( 'removeMediator', mediator );
			}
						
			return mediator;
		}

		/**
		 * Notify <code>Observer</code>s.
		 * <P>
		 * This method is left public mostly for backward 
		 * compatibility, and to allow you to send custom 
		 * notification classes using the facade.</P>
		 *<P> 
		 * Usually you should just call sendNotification
		 * and pass the parameters, never having to 
		 * construct the notification yourself.</P>
		 * 
		 * @param notification the <code>INotification</code> to have the <code>View</code> notify <code>Observers</code> of.
		 */
		override public function notifyObservers ( notification : INotification ) : void 
		{
			super.notifyObservers( notification );
			executeMethod( 'notifyObservers', notification );
		}
  }
}