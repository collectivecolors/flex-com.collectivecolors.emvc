package com.collectivecolors.emvc.interfaces
{
  public interface IContext
  {
    //--------------------------------------------------------------------------
    // Context information
    
    /**
     * Filter down registered extensions to a desired set.
     * 
     * Each context can define whatever properties or methods to act on the 
     * extension array that is passed from the extension manager.
     * 
     * @param extensionMap a map of all registered extensions
     * @return a list of selected extensions filtered by your criteria
     */ 
    function filterExtensions( extensionMap : Object ) : Array;
    
    /**
     * Process extension return values.
     * 
     * This is called after the extensions have executed and returned.
     * 
     * @param values a map of extension return values.
     * @return whatever you want to return.
     */ 
    function returnValues( values : Object ) : *;
  }
}