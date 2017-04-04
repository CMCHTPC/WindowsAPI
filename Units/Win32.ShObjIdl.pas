unit Win32.ShObjIdl;

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes, SysUtils,
    Win32.SHTypes, Win32.ObjIdl,
    Win32.ShellAPI;

{

type
  // IContextMenu = interface;
    IContextMenu2 = interface;
    IContextMenu3 = interface;
    IPersistFolder = interface;
    IRunnableTask = interface;
    IShellTaskScheduler = interface;
    IQueryCodePage = interface;
    IPersistFolder2 = interface;
    IPersistFolder3 = interface;
    IPersistIDList = interface;
    IEnumIDList = interface;
    IEnumFullIDList = interface;
    IFileSyncMergeHandler = interface;
    IObjectWithFolderEnumMode = interface;
    IParseAndCreateItem = interface;
    IShellFolder = interface;
    IEnumExtraSearch = interface;
    IShellFolder2 = interface;
    IFolderViewOptions = interface;
    IShellView = interface;
    IShellView2 = interface;
    IShellView3 = interface;
    IFolderView = interface;
    ISearchBoxInfo = interface;
    IFolderView2 = interface;
    IFolderViewSettings = interface;
    IPreviewHandlerVisuals = interface;
    IVisualProperties = interface;
    ICommDlgBrowser = interface;
    ICommDlgBrowser2 = interface;
    ICommDlgBrowser3 = interface;
    IColumnManager = interface;
    IFolderFilterSite = interface;
    IFolderFilter = interface;
    IInputObjectSite = interface;
    IInputObject = interface;
    IInputObject2 = interface;
    IShellIcon = interface;
    IShellBrowser = interface;
    IUserAccountChangeCallback = interface;
    IEnumShellItems = interface;
    ITransferAdviseSink = interface;
    ITransferSource = interface;
    IEnumResources = interface;
    IShellItemResources = interface;
    ITransferDestination = interface;
    IStreamAsync = interface;
    IStreamUnbufferedInfo = interface;
    IFileOperationProgressSink = interface;
    IShellItemArray = interface;
    IInitializeWithItem = interface;
    IObjectWithSelection = interface;

    IObjectWithBackReferences = interface;
    IPropertyUI = interface;
    ICategoryProvider = interface;
    ICategorizer = interface;
    IDropTargetHelper = interface;
    IDragSourceHelper = interface;
    IDragSourceHelper2 = interface;
    IShellLinkA = interface;
    IShellLinkDataList = interface;
    IResolveShellLink = interface;
    IActionProgressDialog = interface;
    IHWEventHandler = interface;
    IHWEventHandler2 = interface;
    IQueryCancelAutoPlay = interface;
    IDynamicHWHandler = interface;
    IActionProgress = interface;
    IShellExtInit = interface;
    IShellPropSheetExt = interface;
    IRemoteComputer = interface;
    IObjectWithCancelEvent = interface;
    IUserNotification = interface;
    IUserNotificationCallback = interface;
    IUserNotification2 = interface;
    IItemNameLimits = interface;
    ISearchFolderItemFactory = interface;
    IExtractImage = interface;
    IExtractImage2 = interface;
    IThumbnailHandlerFactory = interface;
    IParentAndItem = interface;
    IDockingWindow = interface;
    IDeskBand = interface;
    IDeskBandInfo = interface;
    IDeskBand2 = interface;
    ITaskbarList = interface;
    ITaskbarList2 = interface;
    ITaskbarList3 = interface;
    ITaskbarList4 = interface;
    IStartMenuPinnedList = interface;
    ICDBurn = interface;
    IWizardSite = interface;
    IWizardExtension = interface;
    IWebWizardExtension = interface;
    IPublishingWizard = interface;
    IFolderViewHost = interface;
    IExplorerBrowserEvents = interface;
    IExplorerBrowser = interface;
    IAccessibleObject = interface;
    IResultsFolder = interface;
    IEnumObjects = interface;
    IOperationsProgressDialog = interface;
    IIOCancelInformation = interface;
    IFileOperation = interface;
    IObjectProvider = interface;
    INamespaceWalkCB = interface;
    INamespaceWalkCB2 = interface;
    INamespaceWalk = interface;
    IAutoCompleteDropDown = interface;
    IBandSite = interface;
    IModalWindow = interface;
    ICDBurnExt = interface;
    IContextMenuSite = interface;
    IEnumReadyCallback = interface;
    IEnumerableView = interface;
    IInsertItem = interface;
    IMenuBand = interface;
    IFolderBandPriv = interface;
    IRegTreeItem = interface;
    IImageRecompress = interface;
    IDeskBar = interface;
    IMenuPopup = interface;
    IFileIsInUse = interface;
    IFileDialogEvents = interface;
    IFileDialog = interface;
    IFileSaveDialog = interface;
    IFileOpenDialog = interface;
    IFileDialogCustomize = interface;
    IFileDialogControlEvents = interface;
    IFileDialog2 = interface;
    IApplicationAssociationRegistration = interface;
    IApplicationAssociationRegistrationUI = interface;
    IDelegateFolder = interface;
    IBrowserFrameOptions = interface;
    INewWindowManager = interface;
    IAttachmentExecute = interface;
    IShellMenuCallback = interface;
    IShellMenu = interface;
    IShellRunDll = interface;
    IKnownFolder = interface;
    IKnownFolderManager = interface;
    ISharingConfigurationManager = interface;
    IPreviousVersionsInfo = interface;
    IRelatedItem = interface;
    IIdentityName = interface;
    IDelegateItem = interface;
    ICurrentItem = interface;
    ITransferMediumItem = interface;
    IUseToBrowseItem = interface;
    IDisplayItem = interface;
    IViewStateIdentityItem = interface;
    IPreviewItem = interface;
    IDestinationStreamFactory = interface;
    ICreateProcessInputs = interface;
    ICreatingProcess = interface;
    INewMenuClient = interface;
    IInitializeWithBindCtx = interface;
    IShellItemFilter = interface;
    INameSpaceTreeControl = interface;
    INameSpaceTreeControl2 = interface;
    INameSpaceTreeControlEvents = interface;
    INameSpaceTreeControlDropHandler = interface;
    INameSpaceTreeAccessible = interface;
    INameSpaceTreeControlCustomDraw = interface;
    INameSpaceTreeControlFolderCapabilities = interface;
    IPreviewHandler = interface;
    IPreviewHandlerFrame = interface;
    ITrayDeskBand = interface;
    IBandHost = interface;
    IExplorerPaneVisibility = interface;
    IContextMenuCB = interface;
    IDefaultExtractIconInit = interface;
    IExplorerCommand = interface;
    IExplorerCommandState = interface;
    IInitializeCommand = interface;
    IEnumExplorerCommand = interface;
    IExplorerCommandProvider = interface;
    IMarkupCallback = interface;
    IControlMarkup = interface;
    IInitializeNetworkFolder = interface;
    IOpenControlPanel = interface;
    IComputerInfoChangeNotify = interface;
    IFileSystemBindData = interface;
    IFileSystemBindData2 = interface;
    ICustomDestinationList = interface;
    IApplicationDestinations = interface;
    IApplicationDocumentLists = interface;
    IObjectWithAppUserModelID = interface;
    IObjectWithProgID = interface;
    IUpdateIDList = interface;
    IDesktopGadget = interface;
    IDesktopWallpaper = interface;
    IHomeGroup = interface;
    IInitializeWithPropertyStore = interface;
    IOpenSearchSource = interface;
    IShellLibrary = interface;
    IDefaultFolderMenuInitialize = interface;
    IApplicationActivationManager = interface;
    IVirtualDesktopManager = interface;
    IAssocHandlerInvoker = interface;
    IAssocHandler = interface;
    IEnumAssocHandlers = interface;
    IDataObjectProvider = interface;
    IDataTransferManagerInterop = interface;
    IFrameworkInputPaneHandler = interface;
    IFrameworkInputPane = interface;
    IAccessibilityDockingServiceCallback = interface;
    IAccessibilityDockingService = interface;
    IAppVisibilityEvents = interface;
    IAppVisibility = interface;
    IPackageDebugSettings = interface;
    IPackageDebugSettings2 = interface;
    ISuspensionDependencyManager = interface;
    IExecuteCommandApplicationHostEnvironment = interface;
    IExecuteCommandHost = interface;
    ILaunchTargetMonitor = interface;
    ILaunchSourceViewSizePreference = interface;
    ILaunchTargetViewSizePreference = interface;
    ILaunchSourceAppUserModelId = interface;
    IHandlerInfo = interface;
    IHandlerActivationHost = interface;
    IAppActivationUIInfo = interface;
    IContactManagerInterop = interface;   }


//    {$IF  DEFINED(WINAPI_PARTITION_DESKTOP)}


//===========================================================================

// IContextMenu interface

// [OverView]

//  The shell uses the IContextMenu interface in following three cases.

// case-1: The shell is loading context menu extensions.

//   When the user clicks the right mouse button on an item within the shell's
//  name space (i.g., file, directory, server, work-group, etc.), it creates
//  the default context menu for its type, then loads context menu extensions
//  that are registered for that type (and its base type) so that they can
//  add extra menu items. Those context menu extensions are registered at
//  HKCR\{ProgID}\shellex\ContextMenuHandlers.

// case-2: The shell is retrieving a context menu of sub-folders in extended
//   name-space.

//   When the explorer's name space is extended by name space extensions,
//  the shell calls their IShellFolder::GetUIObjectOf to get the IContextMenu
//  objects when it creates context menus for folders under those extended
//  name spaces.

// case-3: The shell is loading non-default drag and drop handler for directories.

//   When the user performed a non-default drag and drop onto one of file
//  system folders (i.e., directories), it loads shell extensions that are
//  registered at HKCR\{ProgID}\DragDropHandlers.


// [Member functions]


// IContextMenu::QueryContextMenu

//   This member function may insert one or more menuitems to the specified
//  menu (hmenu) at the specified location (indexMenu which is never be -1).
//  The IDs of those menuitem must be in the specified range (idCmdFirst and
//  idCmdLast). It returns the maximum menuitem ID offset (ushort) in the
//  'code' field (low word) of the scode.

//   The uFlags specify the context. It may have one or more of following
//  flags.

//  CMF_DEFAULTONLY: This flag is passed if the user is invoking the default
//   action (typically by double-clicking, case 1 and 2 only). Context menu
//   extensions (case 1) should not add any menu items, and returns S_OK.

//  CMF_VERBSONLY: The explorer passes this flag if it is constructing
//   a context menu for a short-cut object (case 1 and case 2 only). If this
//   flag is passed, it should not add any menu-items that is not appropriate
//   from a short-cut.
//    A good example is the Delete menuitem, which confuses the user
//   because it is not clear whether it deletes the link source item or the
//   link itself.

//  CMF_EXPLORER: The explorer passes this flag if it has the left-side pane
//   (case 1 and 2 only). Context menu extensions should ignore this flag.

//   High word (16-bit) are reserved for context specific communications
//  and the rest of flags (13-bit) are reserved by the system.


// IContextMenu::InvokeCommand

//   This member is called when the user has selected one of menuitems that
//  are inserted by previous QueryContextMenu member. In this case, the
//  LOWORD(lpici->lpVerb) contains the menuitem ID offset (menuitem ID -
//  idCmdFirst).

//   This member function may also be called programmatically. In such a case,
//  lpici->lpVerb specifies the canonical name of the command to be invoked,
//  which is typically retrieved by GetCommandString member previously.

//  Parameters in lpci:
//    cbSize -- Specifies the size of this structure (sizeof(*lpci))
//    hwnd   -- Specifies the owner window for any message/dialog box.
//    fMask  -- Specifies whether or not dwHotkey/hIcon paramter is valid.
//    lpVerb -- Specifies the command to be invoked.
//    lpParameters -- Parameters (optional)
//    lpDirectory  -- Working directory (optional)
//    nShow -- Specifies the flag to be passed to ShowWindow (SW_*).
//    dwHotKey -- Hot key to be assigned to the app after invoked (optional).
//    hIcon -- Specifies the icon (optional).
//    hMonitor -- Specifies the default monitor (optional).


// IContextMenu::GetCommandString

//   This member function is called by the explorer either to get the
//  canonical (language independent) command name (uFlags == GCS_VERB) or
//  the help text ((uFlags & GCS_HELPTEXT) != 0) for the specified command.
//  The retrieved canonical string may be passed to its InvokeCommand
//  member function to invoke a command programmatically. The explorer
//  displays the help texts in its status bar; therefore, the length of
//  the help text should be reasonably short (<40 characters).

//  Parameters:
//   idCmd -- Specifies menuitem ID offset (from idCmdFirst)
//   uFlags -- Either GCS_VERB or GCS_HELPTEXT
//   pwReserved -- Reserved (must pass NULL when calling, must ignore when called)
//   pszName -- Specifies the string buffer.
//   cchMax -- Specifies the size of the string buffer.

//===========================================================================

// QueryContextMenu uFlags
const
    CMF_NORMAL = $00000000;
    CMF_DEFAULTONLY = $00000001;
    CMF_VERBSONLY = $00000002;
    CMF_EXPLORE = $00000004;
    CMF_NOVERBS = $00000008;
    CMF_CANRENAME = $00000010;
    CMF_NODEFAULT = $00000020;
{$IF  (NTDDI_VERSION < NTDDI_VISTA)}
    CMF_INCLUDESTATIC = $00000040;
{$ENDIF}
{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    CMF_ITEMMENU = $00000080;
{$ENDIF}
    CMF_EXTENDEDVERBS = $00000100;
{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    CMF_DISABLEDVERBS = $00000200;
{$ENDIF}
    CMF_ASYNCVERBSTATE = $00000400;
    CMF_OPTIMIZEFORINVOKE = $00000800;
    CMF_SYNCCASCADEMENU = $00001000;
    CMF_DONOTPICKDEFAULT = $00002000;
    CMF_RESERVED = $ffff0000;

    // GetCommandString uFlags
    GCS_VERBA = $00000000;    // canonical verb
    GCS_HELPTEXTA = $00000001;    // help text (for status bar)
    GCS_VALIDATEA = $00000002;    // validate command exists
    GCS_VERBW = $00000004;    // canonical verb (unicode)
    GCS_HELPTEXTW = $00000005;    // help text (unicode version)
    GCS_VALIDATEW = $00000006;    // validate command exists (unicode)
    GCS_VERBICONW = $00000014;   // icon string (unicode)
    GCS_UNICODE = $00000004;     // for bit testing - Unicode string



    CMDSTR_NEWFOLDERA: ansistring = 'NewFolder';
    CMDSTR_VIEWLISTA: ansistring = 'ViewList';
    CMDSTR_VIEWDETAILSA: ansistring = 'ViewDetails';
    CMDSTR_NEWFOLDERW: WideString = 'NewFolder';
    CMDSTR_VIEWLISTW: WideString = 'ViewList';
    CMDSTR_VIEWDETAILSW: WideString = 'ViewDetails';


    SEE_MASK_FLAG_SEPVDM = 0000000; // ToDo very strange ...

    CMIC_MASK_HOTKEY = SEE_MASK_HOTKEY;
    {$IF (NTDDI_VERSION < NTDDI_VISTA)}
    CMIC_MASK_ICON = SEE_MASK_ICON;
    {$ENDIF}// NTDDI_VISTA
    CMIC_MASK_FLAG_NO_UI = SEE_MASK_FLAG_NO_UI;
    CMIC_MASK_UNICODE = SEE_MASK_UNICODE;
    CMIC_MASK_NO_CONSOLE = SEE_MASK_NO_CONSOLE;
{$IF  (NTDDI_VERSION < NTDDI_VISTA)}
    CMIC_MASK_HASLINKNAME = SEE_MASK_HASLINKNAME;
    CMIC_MASK_HASTITLE = SEE_MASK_HASTITLE;
{$ENDIF}// NTDDI_VISTA
    CMIC_MASK_FLAG_SEP_VDM = SEE_MASK_FLAG_SEPVDM;
    CMIC_MASK_ASYNCOK = SEE_MASK_ASYNCOK;
{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    CMIC_MASK_NOASYNC = SEE_MASK_NOASYNC;
{$ENDIF}
    CMIC_MASK_SHIFT_DOWN = $10000000;
    CMIC_MASK_CONTROL_DOWN = $40000000;
    CMIC_MASK_FLAG_LOG_USAGE = SEE_MASK_FLAG_LOG_USAGE;
    CMIC_MASK_NOZONECHECKS = SEE_MASK_NOZONECHECKS;
    CMIC_MASK_PTINVOKE = $20000000;


//include <pshpack8.h>
{$A8}

type
    HMONITOR = THandle;

    TCMINVOKECOMMANDINFO = record
        cbSize: DWORD;
        fMask: DWORD;
        hwnd: HWND;
        lpVerb: LPCSTR;
        lpParameters: LPCSTR;
        lpDirectory: LPCSTR;
        nShow: int32;
        dwHotKey: DWORD;
        hIcon: THANDLE;
    end;

    PCMINVOKECOMMANDINFO = TCMINVOKECOMMANDINFO;


    TCMINVOKECOMMANDINFOEX = record
        cbSize: DWORD;
        fMask: DWORD;
        hwnd: HWND;
        lpVerb: LPCSTR;
        lpParameters: LPCSTR;
        lpDirectory: LPCSTR;
        nShow: int32;
        dwHotKey: DWORD;
        hIcon: THANDLE;
        lpTitle: LPCSTR;
        lpVerbW: LPCWSTR;
        lpParametersW: LPCWSTR;
        lpDirectoryW: LPCWSTR;
        lpTitleW: LPCWSTR;
        ptInvoke: TPOINT;
    end;

    PCMINVOKECOMMANDINFOEX = ^TCMINVOKECOMMANDINFOEX;

    //include <poppack.h>
{$A4}


    IContextMenu = interface(IUnknown)
        ['{000214e4-0000-0000-c000-000000000046}']
        function QueryContextMenu(hmenu: HMENU; indexMenu: UINT; idCmdFirst: UINT; idCmdLast: UINT; uFlags: UINT): HResult; stdcall;
        function InvokeCommand(pici: PCMINVOKECOMMANDINFO): HResult; stdcall;
        function GetCommandString(idCmd: UINT_PTR; uType: UINT; pReserved: PUINT; out pszName: PChar; cchMax: UINT): HResult; stdcall;
    end;

    IContextMenu2 = interface(IContextMenu)
        ['{000214f4-0000-0000-c000-000000000046}']
        function HandleMenuMsg(uMsg: UINT; wParam: WPARAM; lParam: LPARAM): HResult; stdcall;
    end;

    IContextMenu3 = interface(IContextMenu2)
        ['{BCFCE0A0-EC17-11d0-8D10-00A0C90F2719}']
        function HandleMenuMsg2(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; out plResult: LRESULT): HResult; stdcall;
    end;

    IPersistFolder = interface(IPersist)
        ['{000214EA-0000-0000-C000-000000000046}']
        function Initialize(pidl: PCIDLIST_ABSOLUTE): HResult; stdcall;
    end;

const
    IRTIR_TASK_NOT_RUNNING = 0;
    IRTIR_TASK_RUNNING = 1;
    IRTIR_TASK_SUSPENDED = 2;
    IRTIR_TASK_PENDING = 3;
    IRTIR_TASK_FINISHED = 4;




implementation

end.





































