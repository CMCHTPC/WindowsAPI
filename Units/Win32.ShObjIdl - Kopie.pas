unit Win32.ShObjIdl;

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes, SysUtils,
    Win32.SHTypes, Win32.ObjIdl,
    Win32.WTypes, Win32.PropIdl,
    Win32.OleIdl, Win32.PropSys,
    Win32.ObjIdlBase,
    Win32.ShObjIdl_Core,
    Win32.ShellAPI;

const
    shell32_dll = 'Shell32.dll';

const
    IID_IContextMenu: TGUID = '{000214e4-0000-0000-c000-000000000046}';
    IID_IContextMenu2: TGUID = '{000214f4-0000-0000-c000-000000000046}';
    IID_IContextMenu3: TGUID = '{BCFCE0A0-EC17-11d0-8D10-00A0C90F2719}';
    IID_IPersistFolder: TGUID = '{000214EA-0000-0000-C000-000000000046}';

    IID_IRunnableTask: TGUID = '{85788d00-6807-11d0-b810-00c04fd706ec}';
    IID_IShellTaskScheduler: TGUID = '{6CCB7BE0-6807-11d0-B810-00C04FD706EC}';
    IID_IQueryCodePage: TGUID = '{C7B236CE-EE80-11D0-985F-006008059382}';

    IID_IPersistFolder2: TGUID = '{1AC3D9F0-175C-11d1-95BE-00609797EA4F}';
    IID_IPersistFolder3: TGUID = '{CEF04FDF-FE72-11d2-87A5-00C04F6837CF}';
    IID_IPersistIDList: TGUID = '{1079acfc-29bd-11d3-8e0d-00c04f6837d5}';
    IID_IEnumIDList: TGUID = '{000214F2-0000-0000-C000-000000000046}';
    IID_IEnumFullIDList: TGUID = '{d0191542-7954-4908-bc06-b2360bbe45ba}';
    IID_IFileSyncMergeHandler: TGUID = '{d97b5aac-c792-433c-975d-35c4eadc7a9d}';

    IID_IObjectWithFolderEnumMode: TGUID = '{6a9d9026-0e6e-464c-b000-42ecc07de673}';
    IID_IParseAndCreateItem: TGUID = '{67efed0e-e827-4408-b493-78f3982b685c}';
    IID_IShellFolder: TGUID = '{000214E6-0000-0000-C000-000000000046}';
    IID_IEnumExtraSearch: TGUID = '{0E700BE1-9DB6-11d1-A1CE-00C04FD75D13}';
    IID_IShellFolder2: TGUID = '{93F2F68C-1D1B-11d3-A30E-00C04F79ABD1}';
    IID_IFolderViewOptions: TGUID = '{3cc974d2-b302-4d36-ad3e-06d93f695d3f}';

    IID_IShellView: TGUID = '{000214E3-0000-0000-C000-000000000046}';
    IID_IShellView2: TGUID = '{88E39E80-3578-11CF-AE69-08002B2E1262}';
    IID_IShellView3: TGUID = '{ec39fa88-f8af-41c5-8421-38bed28f4673}';
    IID_IFolderView: TGUID = '{cde725b0-ccc9-4519-917e-325d72fab4ce}';
    IID_ISearchBoxInfo: TGUID = '{6af6e03f-d664-4ef4-9626-f7e0ed36755e}';
    IID_IFolderView2: TGUID = '{1af3a467-214f-4298-908e-06b03e0b39f9}';
    IID_IFolderViewSettings: TGUID = '{ae8c987d-8797-4ed3-be72-2a47dd938db0}';
    IID_IPreviewHandlerVisuals: TGUID = '{196bf9a5-b346-4ef0-aa1e-5dcdb76768b1}';
    IID_IVisualProperties: TGUID = '{e693cf68-d967-4112-8763-99172aee5e5a}';
    IID_ICommDlgBrowser: TGUID = '{000214F1-0000-0000-C000-000000000046}';
    IID_ICommDlgBrowser2: TGUID = '{10339516-2894-11d2-9039-00C04F8EEB3E}';
    IID_ICommDlgBrowser3: TGUID = '{c8ad25a1-3294-41ee-8165-71174bd01c57}';
    IID_IColumnManager: TGUID = '{d8ec27bb-3f3b-4042-b10a-4acfd924d453}';
    IID_IFolderFilterSite: TGUID = '{C0A651F5-B48B-11d2-B5ED-006097C686F6}';
    IID_IFolderFilter: TGUID = '{9CC22886-DC8E-11d2-B1D0-00C04F8EEB3E}';
    IID_IInputObjectSite: TGUID = '{F1DB8392-7331-11D0-8C99-00A0C92DBFE8}';
    IID_IInputObject: TGUID = '{68284fAA-6A48-11D0-8c78-00C04fd918b4}';
    IID_IInputObject2: TGUID = '{6915C085-510B-44cd-94AF-28DFA56CF92B}';
    IID_IShellIcon: TGUID = '{000214E5-0000-0000-C000-000000000046}';
    IID_IShellBrowser: TGUID = '{000214E2-0000-0000-C000-000000000046}';
    IID_IUserAccountChangeCallback: TGUID = '{a561e69a-b4b8-4113-91a5-64c6bcca3430}';
    IID_IEnumShellItems: TGUID = '{70629033-e363-4a28-a567-0db78006e6d7}';
    IID_ITransferAdviseSink: TGUID = '{d594d0d8-8da7-457b-b3b4-ce5dbaac0b88}';
    IID_ITransferSource: TGUID = '{00adb003-bde9-45c6-8e29-d09f9353e108}';
    IID_IEnumResources: TGUID = '{2dd81fe3-a83c-4da9-a330-47249d345ba1}';
    IID_IShellItemResources: TGUID = '{ff5693be-2ce0-4d48-b5c5-40817d1acdb9}';
    IID_ITransferDestination: TGUID = '{48addd32-3ca5-4124-abe3-b5a72531b207}';
    IID_IStreamAsync: TGUID = '{fe0b6665-e0ca-49b9-a178-2b5cb48d92a5}';
    IID_IStreamUnbufferedInfo: TGUID = '{8a68fdda-1fdc-4c20-8ceb-416643b5a625}';
    IID_IFileOperationProgressSink: TGUID = '{04b0f1a7-9490-44bc-96e1-4296a31252e2}';
    IID_IShellItemArray: TGUID = '{b63ea76d-1f85-456f-a19c-48159efa858b}';
    IID_IInitializeWithItem: TGUID = '{7f73be3f-fb79-493c-a6c7-7ee14e245841}';
    IID_IObjectWithSelection: TGUID = '{1c9cd5bb-98e9-4491-a60f-31aacc72b83c}';
    IID_IObjectWithBackReferences: TGUID = '{321a6a6a-d61f-4bf3-97ae-14be2986bb36}';
    IID_IPropertyUI: TGUID = '{757a7d9f-919a-4118-99d7-dbb208c8cc66}';
    IID_ICategoryProvider: TGUID = '{9af64809-5864-4c26-a720-c1f78c086ee3}';
    IID_ICategorizer: TGUID = '{a3b14589-9174-49a8-89a3-06a1ae2b9ba7}';
    IID_IDropTargetHelper: TGUID = '{4657278B-411B-11D2-839A-00C04FD918D0}';
    IID_IDragSourceHelper: TGUID = '{DE5BF786-477A-11D2-839D-00C04FD918D0}';
    IID_IDragSourceHelper2: TGUID = '{83E07D0D-0C5F-4163-BF1A-60B274051E40}';
    IID_IShellLinkA: TGUID = '{000214EE-0000-0000-C000-000000000046}';
    IID_IShellLinkDataList: TGUID = '{45e2b4ae-b1c3-11d0-b92f-00a0c90312e1}';
    IID_IResolveShellLink: TGUID = '{5cd52983-9449-11d2-963a-00c04f79adf0}';
    IID_IActionProgressDialog: TGUID = '{49ff1172-eadc-446d-9285-156453a6431c}';
    IID_IHWEventHandler: TGUID = '{C1FB73D0-EC3A-4ba2-B512-8CDB9187B6D1}';
    IID_IHWEventHandler2: TGUID = '{CFCC809F-295D-42e8-9FFC-424B33C487E6}';
    IID_IQueryCancelAutoPlay: TGUID = '{DDEFE873-6997-4e68-BE26-39B633ADBE12}';
    IID_IDynamicHWHandler: TGUID = '{DC2601D7-059E-42fc-A09D-2AFD21B6D5F7}';
    IID_IActionProgress: TGUID = '{49ff1173-eadc-446d-9285-156453a6431c}';
    IID_IShellExtInit: TGUID = '{000214E8-0000-0000-C000-000000000046}';
    IID_IShellPropSheetExt: TGUID = '{000214E9-0000-0000-C000-000000000046}';
    IID_IRemoteComputer: TGUID = '{000214FE-0000-0000-C000-000000000046}';
    IID_IObjectWithCancelEvent: TGUID = '{F279B885-0AE9-4b85-AC06-DDECF9408941}';
    IID_IUserNotification: TGUID = '{ba9711ba-5893-4787-a7e1-41277151550b}';
    IID_IUserNotificationCallback: TGUID = '{19108294-0441-4AFF-8013-FA0A730B0BEA}';
    IID_IUserNotification2: TGUID = '{215913CC-57EB-4FAB-AB5A-E5FA7BEA2A6C}';
    IID_IItemNameLimits: TGUID = '{1df0d7f1-b267-4d28-8b10-12e23202a5c4}';
    IID_ISearchFolderItemFactory: TGUID = '{a0ffbc28-5482-4366-be27-3e81e78e06c2}';
    IID_IExtractImage: TGUID = '{BB2E617C-0920-11d1-9A0B-00C04FC2D6C1}';
    IID_IExtractImage2: TGUID = '{953BB1EE-93B4-11d1-98A3-00C04FB687DA}';
    IID_IThumbnailHandlerFactory: TGUID = '{e35b4b2e-00da-4bc1-9f13-38bc11f5d417}';
    IID_IParentAndItem: TGUID = '{b3a4b685-b685-4805-99d9-5dead2873236}';
    IID_IDockingWindow: TGUID = '{012dd920-7b26-11d0-8ca9-00a0c92dbfe8}';
    IID_IDeskBand: TGUID = '{EB0FE172-1A3A-11D0-89B3-00A0C90A90AC}';
    IID_IDeskBandInfo: TGUID = '{77E425FC-CBF9-4307-BA6A-BB5727745661}';
    IID_IDeskBand2: TGUID = '{79D16DE4-ABEE-4021-8D9D-9169B261D657}';
    IID_ITaskbarList: TGUID = '{56FDF342-FD6D-11d0-958A-006097C9A090}';
    IID_ITaskbarList2: TGUID = '{602D4995-B13A-429b-A66E-1935E44F4317}';




{const
    SID_ShellTaskScheduler = IID_IShellTaskScheduler;   }

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

type

    IRunnableTask = interface(IUnknown)
        ['{85788d00-6807-11d0-b810-00c04fd706ec}']
        function Run(): HResult; stdcall;
        function Kill(bWait: boolean): HResult; stdcall;
        function Suspend(): HResult; stdcall;
        function Resume(): HResult; stdcall;
        function IsRunning(): ULONG; stdcall;
    end;


const
    // ToDo TOID_NULL = GUID_NULL;
    ITSAT_DEFAULT_LPARAM = DWORD_PTR(-1);
    ITSAT_DEFAULT_PRIORITY = $10000000;
    ITSAT_MAX_PRIORITY = $7fffffff;
    ITSAT_MIN_PRIORITY = $00000000;
    ITSSFLAG_COMPLETE_ON_DESTROY = $0000; // wait for the current task to complete before deleting the scheduler
    ITSSFLAG_KILL_ON_DESTROY = $0001; // kill the current task (if there is one) when the task scheduler is deleted
    ITSSFLAG_FLAGS_MASK = $0003;
    ITSS_THREAD_DESTROY_DEFAULT_TIMEOUT = (10 * 1000);      // default milliseconds until a sleeping worker thread is released
    ITSS_THREAD_TERMINATE_TIMEOUT = (INFINITE);     // set sleeping worker threads to never be released
    ITSS_THREAD_TIMEOUT_NO_CHANGE = (INFINITE - 1); // no change to the thread timeout




type
    IShellTaskScheduler = interface(IUnknown)
        ['{6CCB7BE0-6807-11d0-B810-00C04FD706EC}']
        function AddTask(prt: IRunnableTask; rtoid: REFTASKOWNERID; lParam: DWORD_PTR; dwPriority: DWORD): HResult; stdcall;
        function RemoveTasks(rtoid: REFTASKOWNERID; lParam: DWORD_PTR; bWaitIfRunning: boolean): HResult; stdcall;
        function CountTasks(rtoid: REFTASKOWNERID): UINT; stdcall;
        function Status(dwReleaseStatus: DWORD; dwThreadTimeout: DWORD): HResult; stdcall;
    end;




    IQueryCodePage = interface(IUnknown)
        ['{C7B236CE-EE80-11D0-985F-006008059382}']
        function GetCodePage(out puiCodePage: UINT): HResult; stdcall;
        function SetCodePage(uiCodePage: UINT): HResult; stdcall;
    end;



    IPersistFolder2 = interface(IPersistFolder)
        ['{1AC3D9F0-175C-11d1-95BE-00609797EA4F}']
        function GetCurFolder(out ppidl: PIDLIST_ABSOLUTE): HResult; stdcall;
    end;


    //include <pshpack8.h>
{$A8}
    TPERSIST_FOLDER_TARGET_INFO = record
        pidlTargetFolder: PIDLIST_ABSOLUTE;
        szTargetParsingName: array [0.. 259] of WCHAR;
        szNetworkProvider: array [0.. 259] of WCHAR;
        dwAttributes: DWORD;
        csidl: int32;
    end;

    //include <poppack.h>
{$A4}


    IPersistFolder3 = interface(IPersistFolder2)
        ['{CEF04FDF-FE72-11d2-87A5-00C04F6837CF}']
        function InitializeEx(pbc: IBindCtx; pidlRoot: PCIDLIST_ABSOLUTE; const ppfti: TPERSIST_FOLDER_TARGET_INFO): HResult; stdcall;
        function GetFolderTargetInfo(out ppfti: TPERSIST_FOLDER_TARGET_INFO): HResult; stdcall;
    end;


{$IF  (NTDDI_VERSION >= NTDDI_WINXP) or (_WIN32_IE >= _WIN32_IE_IE70)}

    IPersistIDList = interface(IPersist)
        ['{1079acfc-29bd-11d3-8e0d-00c04f6837d5}']
        function SetIDList(pidl: PCIDLIST_ABSOLUTE): HResult; stdcall;
        function GetIDList(out ppidl: PIDLIST_ABSOLUTE): HResult; stdcall;
    end;

{$ENDIF}// NTDDI_WINXP OR  (_WIN32_IE >= _WIN32_IE_IE70)



    IEnumIDList = interface(IUnknown)
        ['{000214F2-0000-0000-C000-000000000046}']
        function Next(celt: ULONG; out rgelt: PITEMID_CHILD; out pceltFetched: ULONG): HResult; stdcall;
        function Skip(celt: ULONG): HResult; stdcall;
        function Reset(): HResult; stdcall;
        function Clone(out ppenum: IEnumIDList): HResult; stdcall;
    end;

    PIEnumIDList = ^IEnumIDList;



    IEnumFullIDList = interface(IUnknown)
        ['{d0191542-7954-4908-bc06-b2360bbe45ba}']
        function Next(celt: ULONG; out rgelt: PIDLIST_ABSOLUTE; out pceltFetched: ULONG): HResult; stdcall;

        function Skip(celt: ULONG): HResult; stdcall;

        function Reset(): HResult; stdcall;

        function Clone(out ppenum: IEnumFullIDList): HResult; stdcall;

    end;


    TSHGDNF = (
        SHGDN_NORMAL = 0,
        SHGDN_INFOLDER = $1,
        SHGDN_FOREDITING = $1000,
        SHGDN_FORADDRESSBAR = $4000,
        SHGDN_FORPARSING = $8000
        );

    TSHCONTF = (
        SHCONTF_CHECKING_FOR_CHILDREN = $10,
        SHCONTF_FOLDERS = $20,
        SHCONTF_NONFOLDERS = $40,
        SHCONTF_INCLUDEHIDDEN = $80,
        SHCONTF_INIT_ON_FIRST_NEXT = $100,
        SHCONTF_NETPRINTERSRCH = $200,
        SHCONTF_SHAREABLE = $400,
        SHCONTF_STORAGE = $800,
        SHCONTF_NAVIGATION_ENUM = $1000,
        SHCONTF_FASTITEMS = $2000,
        SHCONTF_FLATLIST = $4000,
        SHCONTF_ENABLE_ASYNC = $8000,
        SHCONTF_INCLUDESUPERHIDDEN = $10000
        );




const
    SHCIDS_ALLFIELDS = $80000000;
    SHCIDS_CANONICALONLY = $10000000;
    SHCIDS_BITMASK = $FFFF0000;
    SHCIDS_COLUMNMASK = $0000FFFF;

type
    TSYNC_TRANSFER_STATUS = (
        STS_NONE = 0,
        STS_NEEDSUPLOAD = $1,
        STS_NEEDSDOWNLOAD = $2,
        STS_TRANSFERRING = $4,
        STS_PAUSED = $8,
        STS_HASERROR = $10,
        STS_FETCHING_METADATA = $20,
        STS_USER_REQUESTED_REFRESH = $40
        );

    TPLACEHOLDER_STATES = (
        PS_NONE = 0,
        PS_MARKED_FOR_OFFLINE_AVAILABILITY = $1,
        PS_FULL_PRIMARY_STREAM_AVAILABLE = $2,
        PS_CREATE_FILE_ACCESSIBLE = $4,
        PS_ALL = (Ord(PS_MARKED_FOR_OFFLINE_AVAILABILITY) or Ord(PS_FULL_PRIMARY_STREAM_AVAILABLE) or Ord(PS_CREATE_FILE_ACCESSIBLE))
        );

    TSYNC_ENGINE_STATE_FLAGS = (
        SESF_NONE = 0,
        SESF_SERVICE_QUOTA_NEARING_LIMIT = $1,
        SESF_SERVICE_QUOTA_EXCEEDED_LIMIT = $2,
        SESF_AUTHENTICATION_ERROR = $4,
        SESF_PAUSED_DUE_TO_METERED_NETWORK = $8,
        SESF_PAUSED_DUE_TO_DISK_SPACE_FULL = $10,
        SESF_PAUSED_DUE_TO_CLIENT_POLICY = $20,
        SESF_PAUSED_DUE_TO_SERVICE_POLICY = $40,
        SESF_SERVICE_UNAVAILABLE = $80,
        SESF_PAUSED_DUE_TO_USER_REQUEST = $100,
        SESF_ALL_FLAGS = (Ord(SESF_NONE) or Ord(SESF_SERVICE_QUOTA_NEARING_LIMIT) or Ord(SESF_SERVICE_QUOTA_EXCEEDED_LIMIT) or
        Ord(SESF_AUTHENTICATION_ERROR) or Ord(SESF_PAUSED_DUE_TO_METERED_NETWORK) or Ord(SESF_PAUSED_DUE_TO_DISK_SPACE_FULL) or
        Ord(SESF_PAUSED_DUE_TO_CLIENT_POLICY) or Ord(SESF_PAUSED_DUE_TO_SERVICE_POLICY) or Ord(SESF_SERVICE_UNAVAILABLE) or
        Ord(SESF_PAUSED_DUE_TO_USER_REQUEST))
        );




const
    CONFLICT_RESOLUTION_CLSID_KEY: WideString = 'ConflictResolutionCLSID';

type
    TMERGE_UPDATE_STATUS = (
        MUS_COMPLETE = 0,
        MUS_USERINPUTNEEDED = (MUS_COMPLETE + 1),
        MUS_FAILED = (MUS_USERINPUTNEEDED + 1)
        );




    IFileSyncMergeHandler = interface(IUnknown)
        ['{d97b5aac-c792-433c-975d-35c4eadc7a9d}']
        function Merge(localFilePath: LPCWSTR; serverFilePath: LPCWSTR; out updateStatus: TMERGE_UPDATE_STATUS): HResult; stdcall;

        function ShowResolveConflictUIAsync(localFilePath: LPCWSTR; monitorToDisplayOn: HMONITOR): HResult; stdcall;

    end;

const
    STR_BIND_FORCE_FOLDER_SHORTCUT_RESOLVE: WideString = 'Force Folder Shortcut Resolve';
    STR_AVOID_DRIVE_RESTRICTION_POLICY: WideString = 'Avoid Drive Restriction Policy';
    STR_SKIP_BINDING_CLSID: WideString = 'Skip Binding CLSID';
    STR_PARSE_PREFER_FOLDER_BROWSING: WideString = 'Parse Prefer Folder Browsing';
    STR_DONT_PARSE_RELATIVE: WideString = 'Don''t Parse Relative';
    STR_PARSE_TRANSLATE_ALIASES: WideString = 'Parse Translate Aliases';
    STR_PARSE_SKIP_NET_CACHE: WideString = 'Skip Net Resource Cache';
    STR_PARSE_SHELL_PROTOCOL_TO_FILE_OBJECTS: WideString = 'Parse Shell Protocol To File Objects';
{$IF  (_WIN32_IE >= $0700)}
    STR_TRACK_CLSID: WideString = 'Track the CLSID';
    STR_INTERNAL_NAVIGATE: WideString = 'Internal Navigation';
    STR_PARSE_PROPERTYSTORE: WideString = 'DelegateNamedProperties';
    STR_NO_VALIDATE_FILENAME_CHARS: WideString = 'NoValidateFilenameChars';
    STR_BIND_DELEGATE_CREATE_OBJECT: WideString = 'Delegate Object Creation';
    STR_PARSE_ALLOW_INTERNET_SHELL_FOLDERS: WideString = 'Allow binding to Internet shell folder handlers and negate STR_PARSE_PREFER_WEB_BROWSING';
    STR_PARSE_PREFER_WEB_BROWSING: WideString = 'Do not bind to Internet shell folder handlers';
    STR_PARSE_SHOW_NET_DIAGNOSTICS_UI: WideString = 'Show network diagnostics UI';
    STR_PARSE_DONT_REQUIRE_VALIDATED_URLS: WideString = 'Do not require validated URLs';
    STR_INTERNETFOLDER_PARSE_ONLY_URLMON_BINDABLE: WideString = 'Validate URL';
{$ENDIF}// _WIN32_IE >= $0700

{$IF  (NTDDI_VERSION >= NTDDI_WIN8)}
const
    BIND_INTERRUPTABLE = $FFFFFFFF;
{$ENDIF}// NTDDI_WIN8

{$IF  (NTDDI_VERSION >= NTDDI_WIN7)}
const
    STR_BIND_FOLDERS_READ_ONLY: WideString = 'Folders As Read Only';
    STR_BIND_FOLDER_ENUM_MODE: WideString = 'Folder Enum Mode';

type
    TFOLDER_ENUM_MODE = (
        FEM_VIEWRESULT = 0,
        FEM_NAVIGATION = 1
        );

    IObjectWithFolderEnumMode = interface(IUnknown)
        ['{6a9d9026-0e6e-464c-b000-42ecc07de673}']
        function SetMode(feMode: TFOLDER_ENUM_MODE): HResult; stdcall;
        function GetMode(out pfeMode: TFOLDER_ENUM_MODE): HResult; stdcall;
    end;



const
    STR_PARSE_WITH_EXPLICIT_PROGID: WideString = 'ExplicitProgid';
    STR_PARSE_WITH_EXPLICIT_ASSOCAPP: WideString = 'ExplicitAssociationApp';
    STR_PARSE_EXPLICIT_ASSOCIATION_SUCCESSFUL: WideString = 'ExplicitAssociationSuccessful';
    STR_PARSE_AND_CREATE_ITEM: WideString = 'ParseAndCreateItem';
    STR_PROPERTYBAG_PARAM: WideString = 'SHBindCtxPropertyBag';
    STR_ENUM_ITEMS_FLAGS: WideString = 'SHCONTF';




type
    IParseAndCreateItem = interface(IUnknown)
        ['{67efed0e-e827-4408-b493-78f3982b685c}']
        function SetItem(psi: IShellItem): HResult; stdcall;
        function GetItem(const riid: TGUID; out ppv): HResult; stdcall;
    end;


const
    STR_ITEM_CACHE_CONTEXT: WideString = 'ItemCacheContext';
{$ENDIF}// NTDDI_VERSION >= NTDDI_WIN7

type
    IShellFolder = interface(IUnknown)
        ['{000214E6-0000-0000-C000-000000000046}']
        function ParseDisplayName(hwnd: HWND; pbc: IBindCtx; pszDisplayName: LPWSTR; var pchEaten: ULONG;
            out ppidl: PIDLIST_RELATIVE; var pdwAttributes: ULONG): HResult; stdcall;
        function EnumObjects(hwnd: HWND; grfFlags: TSHCONTF; out ppenumIDList: PIEnumIDList): HResult; stdcall;
        function BindToObject(pidl: PCUIDLIST_RELATIVE; pbc: IBindCtx; const riid: TGUID; out ppv): HResult; stdcall;
        function BindToStorage(pidl: PCUIDLIST_RELATIVE; pbc: IBindCtx; const riid: TGUID; out ppv): HResult; stdcall;
        function CompareIDs(lParam: LPARAM; pidl1: PCUIDLIST_RELATIVE; pidl2: PCUIDLIST_RELATIVE): HResult; stdcall;
        function CreateViewObject(hwndOwner: HWND; const riid: TGUID; out ppv): HResult; stdcall;
        function GetAttributesOf(cidl: UINT; apidl: PCUITEMID_CHILD_ARRAY; var rgfInOut: TSFGAOF): HResult; stdcall;
        function GetUIObjectOf(hwndOwner: HWND; cidl: UINT; apidl: PCUITEMID_CHILD_ARRAY; const riid: TGUID;
            var rgfReserved: UINT; out ppv): HResult; stdcall;
        function GetDisplayNameOf(pidl: PCUITEMID_CHILD; uFlags: TSHGDNF; out pName: TSTRRET): HResult; stdcall;
        function SetNameOf(hwnd: HWND; pidl: PCUITEMID_CHILD; pszName: LPCWSTR; uFlags: TSHGDNF;
            out ppidlOut: PITEMID_CHILD): HResult; stdcall;
    end;


    PIShellFolder = ^IShellFolder;



    TEXTRASEARCH = record
        guidSearch: TGUID;
        wszFriendlyName: array [0..79] of WCHAR;
        wszUrl: array [0.. 2083] of WCHAR;
    end;
    PEXTRASEARCH = ^TEXTRASEARCH;




    IEnumExtraSearch = interface(IUnknown)
        ['{0E700BE1-9DB6-11d1-A1CE-00C04FD75D13}']
        function Next(celt: ULONG; out rgelt: PEXTRASEARCH; out pceltFetched: ULONG): HResult; stdcall;
        function Skip(celt: ULONG): HResult; stdcall;
        function Reset(): HResult; stdcall;
        function Clone(out ppenum: IEnumExtraSearch): HResult; stdcall;
    end;

    PIEnumExtraSearch = ^IEnumExtraSearch;




    IShellFolder2 = interface(IShellFolder)
        ['{93F2F68C-1D1B-11d3-A30E-00C04F79ABD1}']
        function GetDefaultSearchGUID(out pguid: TGUID): HResult; stdcall;
        function EnumSearches(out ppenum: IEnumExtraSearch): HResult; stdcall;
        function GetDefaultColumn(dwRes: DWORD; out pSort: ULONG; out pDisplay: ULONG): HResult; stdcall;
        function GetDefaultColumnState(iColumn: UINT; out pcsFlags: TSHCOLSTATEF): HResult; stdcall;
        function GetDetailsEx(pidl: PCUITEMID_CHILD; const pscid: TSHCOLUMNID; out pv: variant): HResult; stdcall;
        function GetDetailsOf(pidl: PCUITEMID_CHILD; iColumn: UINT; out psd: TSHELLDETAILS): HResult; stdcall;
        function MapColumnToSCID(iColumn: UINT; out pscid: TSHCOLUMNID): HResult; stdcall;
    end;




    PVIEWSETTINGS = ^char;



    TFOLDERFLAGS = (
        FWF_NONE = 0,
        FWF_AUTOARRANGE = $1,
        FWF_ABBREVIATEDNAMES = $2,
        FWF_SNAPTOGRID = $4,
        FWF_OWNERDATA = $8,
        FWF_BESTFITWINDOW = $10,
        FWF_DESKTOP = $20,
        FWF_SINGLESEL = $40,
        FWF_NOSUBFOLDERS = $80,
        FWF_TRANSPARENT = $100,
        FWF_NOCLIENTEDGE = $200,
        FWF_NOSCROLL = $400,
        FWF_ALIGNLEFT = $800,
        FWF_NOICONS = $1000,
        FWF_SHOWSELALWAYS = $2000,
        FWF_NOVISIBLE = $4000,
        FWF_SINGLECLICKACTIVATE = $8000,
        FWF_NOWEBVIEW = $10000,
        FWF_HIDEFILENAMES = $20000,
        FWF_CHECKSELECT = $40000,
        FWF_NOENUMREFRESH = $80000,
        FWF_NOGROUPING = $100000,
        FWF_FULLROWSELECT = $200000,
        FWF_NOFILTERS = $400000,
        FWF_NOCOLUMNHEADER = $800000,
        FWF_NOHEADERINALLVIEWS = $1000000,
        FWF_EXTENDEDTILES = $2000000,
        FWF_TRICHECKSELECT = $4000000,
        FWF_AUTOCHECKSELECT = $8000000,
        FWF_NOBROWSERVIEWSTATE = $10000000,
        FWF_SUBSETGROUPS = $20000000,
        FWF_USESEARCHFOLDER = $40000000,
        FWF_ALLOWRTLREADING = $80000000
        );




    TFOLDERVIEWMODE = (
        FVM_AUTO = -1,
        FVM_FIRST = 1,
        FVM_ICON = 1,
        FVM_SMALLICON = 2,
        FVM_LIST = 3,
        FVM_DETAILS = 4,
        FVM_THUMBNAIL = 5,
        FVM_TILE = 6,
        FVM_THUMBSTRIP = 7,
        FVM_CONTENT = 8,
        FVM_LAST = 8
        );

{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    TFOLDERLOGICALVIEWMODE = (
        FLVM_UNSPECIFIED = -1,
        FLVM_FIRST = 1,
        FLVM_DETAILS = 1,
        FLVM_TILES = 2,
        FLVM_ICONS = 3,
        FLVM_LIST = 4,
        FLVM_CONTENT = 5,
        FLVM_LAST = 5
        );

{$ENDIF}// NTDDI_VISTA
    TFOLDERSETTINGS = record
        ViewMode: UINT;
        fFlags: UINT;
    end;

    PFOLDERSETTINGS = ^TFOLDERSETTINGS;

    PCFOLDERSETTINGS = ^TFOLDERSETTINGS;


    TFOLDERVIEWOPTIONS = (
        FVO_DEFAULT = 0,
        FVO_VISTALAYOUT = $1,
        FVO_CUSTOMPOSITION = $2,
        FVO_CUSTOMORDERING = $4,
        FVO_SUPPORTHYPERLINKS = $8,
        FVO_NOANIMATIONS = $10,
        FVO_NOSCROLLTIPS = $20
        );


    IFolderViewOptions = interface(IUnknown)
        ['{3cc974d2-b302-4d36-ad3e-06d93f695d3f}']
        function SetFolderViewOptions(fvoMask: TFOLDERVIEWOPTIONS; fvoFlags: TFOLDERVIEWOPTIONS): HResult; stdcall;
        function GetFolderViewOptions(out pfvoFlags: TFOLDERVIEWOPTIONS): HResult; stdcall;
    end;


    TSVSIF = (
        SVSI_DESELECT = 0,
        SVSI_SELECT = $1,
        SVSI_EDIT = $3,
        SVSI_DESELECTOTHERS = $4,
        SVSI_ENSUREVISIBLE = $8,
        SVSI_FOCUSED = $10,
        SVSI_TRANSLATEPT = $20,
        SVSI_SELECTIONMARK = $40,
        SVSI_POSITIONITEM = $80,
        SVSI_CHECK = $100,
        SVSI_CHECK2 = $200,
        SVSI_KEYBOARDSELECT = $401,
        SVSI_NOTAKEFOCUS = $40000000
        );

const
    SVSI_NOSTATECHANGE = UINT($80000000); // work around the use of the high bit that results in 4245: signed/unsigned mismatch

type
    TSVGIO = (
        SVGIO_BACKGROUND = INT32(0),
        SVGIO_SELECTION = INT32($1),
        SVGIO_ALLVIEW = INT32($2),
        SVGIO_CHECKED = INT32($3),
        SVGIO_TYPE_MASK = INT32($f),
        SVGIO_FLAG_VIEWORDER = INT32($80000000)
        );

    TSVUIA_STATUS = (
        SVUIA_DEACTIVATE = 0,
        SVUIA_ACTIVATE_NOFOCUS = 1,
        SVUIA_ACTIVATE_FOCUS = 2,
        SVUIA_INPLACEACTIVATE = 3
        );


type
    LPFNSVADDPROPSHEETPAGE = LPARAM;


    IShellBrowser = interface;

    IShellView = interface(IOleWindow)
        ['{000214E3-0000-0000-C000-000000000046}']
        function TranslateAccelerator(pmsg: PMSG): HResult; stdcall;
        function EnableModeless(fEnable: boolean): HResult; stdcall;
        function UIActivate(uState: UINT): HResult; stdcall;
        function Refresh(): HResult; stdcall;
        function CreateViewWindow(psvPrevious: IShellView; pfs: PCFOLDERSETTINGS; psb: IShellBrowser;
            const prcView: TRECT; out phWnd: HWND): HResult; stdcall;
        function DestroyViewWindow(): HResult; stdcall;
        function GetCurrentInfo(out pfs: TFOLDERSETTINGS): HResult; stdcall;
        function AddPropertySheetPages(dwReserved: DWORD; pfn: LPFNSVADDPROPSHEETPAGE; lparam: LPARAM): HResult; stdcall;
        function SaveViewState(): HResult; stdcall;
        function SelectItem(pidlItem: PCUITEMID_CHILD; uFlags: TSVSIF): HResult; stdcall;
        function GetItemObject(uItem: UINT; const riid: TGUID; out ppv): HResult; stdcall;
    end;

    PIShellView = ^IShellView;

    PTBBUTTONSB = PTBBUTTON;

    IShellBrowser = interface(IOleWindow)
        ['{000214E2-0000-0000-C000-000000000046}']
        function InsertMenusSB(hmenuShared: HMENU; var lpMenuWidths: POLEMENUGROUPWIDTHS): HResult; stdcall;
        function SetMenuSB(hmenuShared: HMENU; holemenuRes: HOLEMENU; hwndActiveObject: HWND): HResult; stdcall;
        function RemoveMenusSB(hmenuShared: HMENU): HResult; stdcall;
        function SetStatusTextSB(pszStatusText: LPCWSTR): HResult; stdcall;
        function EnableModelessSB(fEnable: boolean): HResult; stdcall;
        function TranslateAcceleratorSB(pmsg: PMSG; wID: word): HResult; stdcall;
        function BrowseObject(pidl: PCUIDLIST_RELATIVE; wFlags: UINT): HResult; stdcall;
        function GetViewStateStream(grfMode: DWORD; out ppStrm: IStream): HResult; stdcall;
        function GetControlWindow(id: UINT; out phwnd: HWND): HResult; stdcall;
        function SendControlMsg(id: UINT; uMsg: UINT; wParam: WPARAM; lParam: LPARAM; out pret: LRESULT): HResult; stdcall;
        function QueryActiveShellView(out ppshv: IShellView): HResult; stdcall;
        function OnViewWindowActive(pshv: IShellView): HResult; stdcall;
        function SetToolbarItems(lpButtons: PTBBUTTONSB; nButtons: UINT; uFlags: UINT): HResult; stdcall;
    end;

    PIShellBrowser = ^IShellBrowser;

type
    TSHELLVIEWID = TGUID;
    PSHELLVIEWID = ^TSHELLVIEWID;

const
    SV2GV_CURRENTVIEW = UINT(-1);
    SV2GV_DEFAULTVIEW = UINT(-2);
//include <pshpack8.h>
{$A8}
type
    TSV2CVW2_PARAMS = record
        cbSize: DWORD;
        psvPrev: IShellView;
        pfs: PCFOLDERSETTINGS;
        psbOwner: IShellBrowser;
        prcView: PRECT;
        pvid: PSHELLVIEWID;
        hwndView: HWND;
    end;

    PSV2CVW2_PARAMS = ^TSV2CVW2_PARAMS;

    //include <poppack.h>
{$A4}

    IShellView2 = interface(IShellView)
        ['{88E39E80-3578-11CF-AE69-08002B2E1262}']
        function GetView(var pvid: TSHELLVIEWID; uView: ULONG): HResult; stdcall;
        function CreateViewWindow2(lpParams: PSV2CVW2_PARAMS): HResult; stdcall;
        function HandleRename(pidlNew: PCUITEMID_CHILD): HResult; stdcall;
        function SelectAndPositionItem(pidlItem: PCUITEMID_CHILD; uFlags: UINT; ppt: PPOINT): HResult; stdcall;
    end;




{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}

    TSV3CVW3_FLAGS = (
        SV3CVW3_DEFAULT = DWORD(0),
        SV3CVW3_NONINTERACTIVE = DWORD($1),
        SV3CVW3_FORCEVIEWMODE = DWORD($2),
        SV3CVW3_FORCEFOLDERFLAGS = DWORD($4)
        );


    IShellView3 = interface(IShellView2)
        ['{ec39fa88-f8af-41c5-8421-38bed28f4673}']
        function CreateViewWindow3(psbOwner: IShellBrowser; psvPrev: IShellView; dwViewFlags: TSV3CVW3_FLAGS;
            dwMask: TFOLDERFLAGS; dwFlags: TFOLDERFLAGS; fvMode: TFOLDERVIEWMODE; const pvid: TSHELLVIEWID;
            const prcView: TRECT; out phwndView: HWND): HResult; stdcall;
    end;


{$ENDIF}// NTDDI_VISTA




    IFolderView = interface(IUnknown)
        ['{cde725b0-ccc9-4519-917e-325d72fab4ce}']
        function GetCurrentViewMode(out pViewMode: UINT): HResult; stdcall;
        function SetCurrentViewMode(ViewMode: UINT): HResult; stdcall;
        function GetFolder(const riid: TGUID; out ppv): HResult; stdcall;
        function Item(iItemIndex: int32; out ppidl: PITEMID_CHILD): HResult; stdcall;
        function ItemCount(uFlags: UINT; out pcItems: int32): HResult; stdcall;
        function Items(uFlags: UINT; const riid: TGUID; out ppv): HResult; stdcall;
        function GetSelectionMarkedItem(out piItem: int32): HResult; stdcall;
        function GetFocusedItem(out piItem: int32): HResult; stdcall;
        function GetItemPosition(pidl: PCUITEMID_CHILD; out ppt: TPOINT): HResult; stdcall;
        function GetSpacing(var ppt: TPOINT): HResult; stdcall;
        function GetDefaultSpacing(out ppt: TPOINT): HResult; stdcall;
        function GetAutoArrange(): HResult; stdcall;
        function SelectItem(iItem: int32; dwFlags: DWORD): HResult; stdcall;
        function SelectAndPositionItems(cidl: UINT; apidl: PCUITEMID_CHILD_ARRAY; apt: PPOINT; dwFlags: DWORD): HResult; stdcall;
    end;




{$IF  (NTDDI_VERSION >= NTDDI_WIN7)}




    ISearchBoxInfo = interface(IUnknown)
        ['{6af6e03f-d664-4ef4-9626-f7e0ed36755e}']
        function GetCondition(const riid: TGUID; out ppv): HResult; stdcall;

        function GetText(out ppsz: LPWSTR): HResult; stdcall;

    end;



{$ENDIF}// (NTDDI_VERSION >= NTDDI_WIN7)

{$IF  (NTDDI_VERSION >= NTDDI_VISTA)  OR  (_WIN32_IE >= _WIN32_IE_IE70)}
    TSORTDIRECTION = (
        SORT_DESCENDING = int32(-1),
        SORT_ASCENDING = int32(1)
        );

    TSORTCOLUMN = record
        propkey: TPROPERTYKEY;
        direction: TSORTDIRECTION;
    end;
    PSORTCOLUMN = ^TSORTCOLUMN;

    TFVTEXTTYPE = (
        FVST_EMPTYTEXT = 0
        );

    PIShellItemArray = ^IShellItemArray;

    IFolderView2 = interface(IFolderView)
        ['{1af3a467-214f-4298-908e-06b03e0b39f9}']
        function SetGroupBy(const key: TPROPERTYKEY; fAscending: boolean): HResult; stdcall;
        function GetGroupBy(out pkey: TPROPERTYKEY; out pfAscending: boolean): HResult; stdcall;
        function SetViewProperty(pidl: PCUITEMID_CHILD; const propkey: TPROPERTYKEY; const propvar: TPROPVARIANT): HRESULT; deprecated;
            stdcall;
        function GetViewProperty(pidl: PCUITEMID_CHILD; const propkey: TPROPERTYKEY; out ppropvar: TPROPVARIANT): HRESULT; deprecated;
            stdcall;
        function SetTileViewProperties(pidl: PCUITEMID_CHILD; pszPropList: LPCWSTR): HRESULT; deprecated;
            stdcall;
        function SetExtendedTileViewProperties(pidl: PCUITEMID_CHILD; pszPropList: LPCWSTR): HRESULT; deprecated;
            stdcall;
        function SetText(iType: TFVTEXTTYPE; pwszText: LPCWSTR): HResult; stdcall;
        function SetCurrentFolderFlags(dwMask: DWORD; dwFlags: DWORD): HResult; stdcall;
        function GetCurrentFolderFlags(out pdwFlags: DWORD): HResult; stdcall;
        function GetSortColumnCount(out pcColumns: int32): HResult; stdcall;
        function SetSortColumns(rgSortColumns: PSORTCOLUMN; cColumns: int32): HResult; stdcall;
        function GetSortColumns(rgSortColumns: PSORTCOLUMN; cColumns: int32): HResult; stdcall;
        function GetItem(iItem: int32; const riid: TGUID; out ppv): HResult; stdcall;
        function GetVisibleItem(iStart: int32; fPrevious: boolean; out piItem: int32): HResult; stdcall;
        function GetSelectedItem(iStart: int32; out piItem: int32): HResult; stdcall;
        function GetSelection(fNoneImpliesFolder: boolean; out ppsia: PIShellItemArray): HResult; stdcall;
        function GetSelectionState(pidl: PCUITEMID_CHILD; out pdwFlags: DWORD): HResult; stdcall;
        function InvokeVerbOnSelection(pszVerb: LPCSTR): HResult; stdcall;
        function SetViewModeAndIconSize(uViewMode: TFOLDERVIEWMODE; iImageSize: int32): HResult; stdcall;
        function GetViewModeAndIconSize(out puViewMode: TFOLDERVIEWMODE; out piImageSize: int32): HResult; stdcall;
        function SetGroupSubsetCount(cVisibleRows: UINT): HResult; stdcall;
        function GetGroupSubsetCount(out pcVisibleRows: UINT): HResult; stdcall;
        function SetRedraw(fRedrawOn: boolean): HResult; stdcall;
        function IsMoveInSameFolder(): HResult; stdcall;
        function DoRename(): HResult; stdcall;
    end;


    TSIATTRIBFLAGS = (
        SIATTRIBFLAGS_AND = $1,
        SIATTRIBFLAGS_OR = $2,
        SIATTRIBFLAGS_APPCOMPAT = $3,
        SIATTRIBFLAGS_MASK = $3,
        SIATTRIBFLAGS_ALLITEMS = $4000
        );




    IShellItemArray = interface(IUnknown)
        ['{b63ea76d-1f85-456f-a19c-48159efa858b}']
        function BindToHandler(pbc: IBindCtx; const bhid: TGUID; const riid: TGUID; out ppvOut): HResult; stdcall;
        function GetPropertyStore(flags: TGETPROPERTYSTOREFLAGS; const riid: TGUID; out ppv): HResult; stdcall;
        function GetPropertyDescriptionList(const keyType: TPROPERTYKEY; const riid: TGUID; out ppv): HResult; stdcall;
        function GetAttributes(AttribFlags: TSIATTRIBFLAGS; sfgaoMask: TSFGAOF; out psfgaoAttribs: TSFGAOF): HResult; stdcall;
        function GetCount(out pdwNumItems: DWORD): HResult; stdcall;
        function GetItemAt(dwIndex: DWORD; out ppsi: IShellItem): HResult; stdcall;
        function EnumItems(out ppenumShellItems: IEnumShellItems): HResult; stdcall;
    end;




{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    IFolderViewSettings = interface(IUnknown)
        ['{ae8c987d-8797-4ed3-be72-2a47dd938db0}']
        function GetColumnPropertyList(const riid: TGUID; out ppv): HResult; stdcall;
        function GetGroupByProperty(out pkey: TPROPERTYKEY; out pfGroupAscending: boolean): HResult; stdcall;
        function GetViewMode(out plvm: TFOLDERLOGICALVIEWMODE): HResult; stdcall;
        function GetIconSize(out puIconSize: UINT): HResult; stdcall;
        function GetFolderFlags(out pfolderMask: TFOLDERFLAGS; out pfolderFlags: TFOLDERFLAGS): HResult; stdcall;
        function GetSortColumns(rgSortColumns: PSORTCOLUMN; cColumnsIn: UINT; out pcColumnsOut: UINT): HResult; stdcall;
        function GetGroupSubsetCount(out pcVisibleRows: UINT): HResult; stdcall;
    end;

{$ENDIF}// NTDDI_VISTA

{$ENDIF}// (_WIN32_IE >= _WIN32_IE_IE70)

{$IF  (_WIN32_IE >= _WIN32_IE_IE70)}
    IPreviewHandlerVisuals = interface(IUnknown)
        ['{196bf9a5-b346-4ef0-aa1e-5dcdb76768b1}']
        function SetBackgroundColor(color: TCOLORREF): HResult; stdcall;
        function SetFont(const plf: TLOGFONTW): HResult; stdcall;
        function SetTextColor(color: TCOLORREF): HResult; stdcall;
    end;

    TVPWATERMARKFLAGS = (
        VPWF_DEFAULT = 0,
        VPWF_ALPHABLEND = $1
        );

    TVPCOLORFLAGS = (
        VPCF_TEXT = 1,
        VPCF_BACKGROUND = 2,
        VPCF_SORTCOLUMN = 3,
        VPCF_SUBTEXT = 4,
        VPCF_TEXTBACKGROUND = 5
        );


    IVisualProperties = interface(IUnknown)
        ['{e693cf68-d967-4112-8763-99172aee5e5a}']
        function SetWatermark(hbmp: HBITMAP; vpwf: TVPWATERMARKFLAGS): HResult; stdcall;
        function SetColor(vpcf: TVPCOLORFLAGS; cr: TCOLORREF): HResult; stdcall;
        function GetColor(vpcf: TVPCOLORFLAGS; out pcr: TCOLORREF): HResult; stdcall;
        function SetItemHeight(cyItemInPixels: int32): HResult; stdcall;
        function GetItemHeight(out cyItemInPixels: int32): HResult; stdcall;
        function SetFont(const plf: TLOGFONTW; bRedraw: boolean): HResult; stdcall;
        function GetFont(out plf: TLOGFONTW): HResult; stdcall;
        function SetTheme(pszSubAppName: LPCWSTR; pszSubIdList: LPCWSTR): HResult; stdcall;
    end;

{$ENDIF}// _WIN32_IE_IE70


const
    CDBOSC_SETFOCUS = $00000000;
    CDBOSC_KILLFOCUS = $00000001;
    CDBOSC_SELCHANGE = $00000002;
    CDBOSC_RENAME = $00000003;
    CDBOSC_STATECHANGE = $00000004;


type
    ICommDlgBrowser = interface(IUnknown)
        ['{000214F1-0000-0000-C000-000000000046}']
        function OnDefaultCommand(ppshv: IShellView): HResult; stdcall;
        function OnStateChange(ppshv: IShellView; uChange: ULONG): HResult; stdcall;
        function IncludeObject(ppshv: IShellView; pidl: PCUITEMID_CHILD): HResult; stdcall;
    end;

    PICommDlgBrowser = ^ICommDlgBrowser;


{$IF  (NTDDI_VERSION >= NTDDI_WIN2K)}
const
    CDB2N_CONTEXTMENU_DONE = $00000001;
    CDB2N_CONTEXTMENU_START = $00000002;
    CDB2GVF_SHOWALLFILES = $00000001;
{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
const
    CDB2GVF_ISFILESAVE = $00000002; // is file save, else file open
    CDB2GVF_ALLOWPREVIEWPANE = $00000004;
    CDB2GVF_NOSELECTVERB = $00000008;
    CDB2GVF_NOINCLUDEITEM = $00000010;
    CDB2GVF_ISFOLDERPICKER = $00000020;
    CDB2GVF_ADDSHIELD = $00000040;
// when CDB2GVF_NOSELECTVERB is not specified this flag controls the display of a LUA shield on the Select menu item
{$ENDIF}// NTDDI_VISTA




type
    ICommDlgBrowser2 = interface(ICommDlgBrowser)
        ['{10339516-2894-11d2-9039-00C04F8EEB3E}']
        function Notify(ppshv: IShellView; dwNotifyType: DWORD): HResult; stdcall;
        function GetDefaultMenuText(ppshv: IShellView; out pszText: LPWSTR; cchMax: int32): HResult; stdcall;
        function GetViewFlags(out pdwFlags: DWORD): HResult; stdcall;
    end;

    PICommDlgBrowser2 = ^ICommDlgBrowser2;


{$ENDIF}// NTDDI_WIN2K
{$IF  (_WIN32_IE >= _WIN32_IE_IE70)}
    ICommDlgBrowser3 = interface(ICommDlgBrowser2)
        ['{c8ad25a1-3294-41ee-8165-71174bd01c57}']
        function OnColumnClicked(ppshv: IShellView; iColumn: int32): HResult; stdcall;
        function GetCurrentFilter(out pszFileSpec: LPWSTR; cchFileSpec: int32): HResult; stdcall;
        function OnPreViewCreated(ppshv: IShellView): HResult; stdcall;
    end;


    TCM_MASK = (
        CM_MASK_WIDTH = $1,
        CM_MASK_DEFAULTWIDTH = $2,
        CM_MASK_IDEALWIDTH = $4,
        CM_MASK_NAME = $8,
        CM_MASK_STATE = $10
        );

    TCM_STATE = (
        CM_STATE_NONE = 0,
        CM_STATE_VISIBLE = $1,
        CM_STATE_FIXEDWIDTH = $2,
        CM_STATE_NOSORTBYFOLDERNESS = $4,
        CM_STATE_ALWAYSVISIBLE = $8
        );

    TCM_ENUM_FLAGS = (
        CM_ENUM_ALL = $1,
        CM_ENUM_VISIBLE = $2
        );

    TCM_SET_WIDTH_VALUE = (
        CM_WIDTH_USEDEFAULT = -1,
        CM_WIDTH_AUTOSIZE = -2
        );

    TCM_COLUMNINFO = record
        cbSize: DWORD;
        dwMask: DWORD;
        dwState: DWORD;
        uWidth: UINT;
        uDefaultWidth: UINT;
        uIdealWidth: UINT;
        wszName: array [0.. 79] of WCHAR;
    end;
    PCM_COLUMNINFO = ^TCM_COLUMNINFO;



    IColumnManager = interface(IUnknown)
        ['{d8ec27bb-3f3b-4042-b10a-4acfd924d453}']
        function SetColumnInfo(const propkey: TPROPERTYKEY; const pcmci: TCM_COLUMNINFO): HResult; stdcall;
        function GetColumnInfo(const propkey: TPROPERTYKEY; var pcmci: TCM_COLUMNINFO): HResult; stdcall;
        function GetColumnCount(dwFlags: TCM_ENUM_FLAGS; out puCount: UINT): HResult; stdcall;
        function GetColumns(dwFlags: TCM_ENUM_FLAGS; out rgkeyOrder: PPROPERTYKEY; cColumns: UINT): HResult; stdcall;
        function SetColumns(rgkeyOrder: PPROPERTYKEY; cVisible: UINT): HResult; stdcall;
    end;

    {$ENDIF}// (_WIN32_IE >= _WIN32_IE_IE70)


    IFolderFilterSite = interface(IUnknown)
        ['{C0A651F5-B48B-11d2-B5ED-006097C686F6}']
        function SetFilter(punk: IUnknown): HResult; stdcall;
    end;

    IFolderFilter = interface(IUnknown)
        ['{9CC22886-DC8E-11d2-B1D0-00C04F8EEB3E}']
        function ShouldShow(psf: IShellFolder; pidlFolder: PCIDLIST_ABSOLUTE; pidlItem: PCUITEMID_CHILD): HResult; stdcall;
        function GetEnumFlags(psf: IShellFolder; pidlFolder: PCIDLIST_ABSOLUTE; out phwnd: HWND; var pgrfFlags: DWORD): HResult; stdcall;
    end;


    IInputObjectSite = interface(IUnknown)
        ['{F1DB8392-7331-11D0-8C99-00A0C92DBFE8}']
        function OnFocusChangeIS(punkObj: IUnknown; fSetFocus: boolean): HResult; stdcall;

    end;

    IInputObject = interface(IUnknown)
        ['{68284fAA-6A48-11D0-8c78-00C04fd918b4}']
        function UIActivateIO(fActivate: boolean; pMsg: PMSG): HResult; stdcall;
        function HasFocusIO(): HResult; stdcall;
        function TranslateAcceleratorIO(pMsg: PMSG): HResult; stdcall;

    end;

    IInputObject2 = interface(IInputObject)
        ['{6915C085-510B-44cd-94AF-28DFA56CF92B}']
        function TranslateAcceleratorGlobal(pMsg: PMSG): HResult; stdcall;
    end;

    IShellIcon = interface(IUnknown)
        ['{000214E5-0000-0000-C000-000000000046}']
        function GetIconOf(pidl: PCUITEMID_CHILD; flags: UINT; out pIconIndex: int32): HResult; stdcall;
    end;



const
    SBSP_DEFBROWSER = $0000;
    SBSP_SAMEBROWSER = $0001;
    SBSP_NEWBROWSER = $0002;
    SBSP_DEFMODE = $0000;
    SBSP_OPENMODE = $0010;
    SBSP_EXPLOREMODE = $0020;
    SBSP_HELPMODE = $0040;
    SBSP_NOTRANSFERHIST = $0080;
    SBSP_ABSOLUTE = $0000;
    SBSP_RELATIVE = $1000;
    SBSP_PARENT = $2000;
    SBSP_NAVIGATEBACK = $4000;
    SBSP_NAVIGATEFORWARD = $8000;
    SBSP_ALLOW_AUTONAVIGATE = $00010000;
{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    SBSP_KEEPSAMETEMPLATE = $00020000;
    SBSP_KEEPWORDWHEELTEXT = $00040000;
    SBSP_ACTIVATE_NOFOCUS = $00080000;
    SBSP_CREATENOHISTORY = $00100000;
    SBSP_PLAYNOSOUND = $00200000;
{$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)
{$IF  (_WIN32_IE >= _WIN32_IE_IE60SP2)}
    SBSP_CALLERUNTRUSTED = $00800000;
    SBSP_TRUSTFIRSTDOWNLOAD = $01000000;
    SBSP_UNTRUSTEDFORDOWNLOAD = $02000000;
{$ENDIF}// _WIN32_IE_IE60SP2
    SBSP_NOAUTOSELECT = $04000000;
    SBSP_WRITENOHISTORY = $08000000;
{$IF  (_WIN32_IE >= _WIN32_IE_IE60SP2)}
    SBSP_TRUSTEDFORACTIVEX = $10000000;
{$ENDIF}// _WIN32_IE_IE60SP2
{$IF  (_WIN32_IE >= _WIN32_IE_IE70)}
    SBSP_FEEDNAVIGATION = $20000000;
{$ENDIF}// _WIN32_IE_IE70
    SBSP_REDIRECT = $40000000;
    SBSP_INITIATEDBYHLINKFRAME = $80000000;
    FCW_STATUS = $0001;
    FCW_TOOLBAR = $0002;
    FCW_TREE = $0003;
    FCW_INTERNETBAR = $0006;
    FCW_PROGRESS = $0008;
{$IF  (_WIN32_IE >= $0700)}
{$ENDIF}
    FCT_MERGE = $0001;
    FCT_CONFIGABLE = $0002;
    FCT_ADDTOEND = $0004;


const
    STR_DONT_RESOLVE_LINK: WideString = 'Don''t Resolve Link';
    STR_GET_ASYNC_HANDLER: WideString = 'GetAsyncHandler';


function SHSimpleIDListFromPath(pszPath: PCWSTR): PIDLIST_ABSOLUTE; stdcall; external shell32_dll;

{$IF  (_WIN32_IE >= _WIN32_IE_IE70)}
// CLSID_ShellItem create and init helper APIs. produce IShellItem derived interfaces from these different expressions of an item
function SHCreateItemFromIDList(pidl: PCIDLIST_ABSOLUTE; const riid: TGUID; out ppv): HResult; stdcall; external shell32_dll;
function SHCreateItemFromParsingName(pszPath: PCWSTR; pbc: IBindCtx; const riid: TGUID; out ppv): HResult; stdcall; external shell32_dll;
function SHCreateItemWithParent(pidlParent: PCIDLIST_ABSOLUTE; psfParent: IShellFolder; pidl: PCUITEMID_CHILD;
    const riid: TGUID; out ppvItem): HResult; stdcall; external shell32_dll;
function SHCreateItemFromRelativeName(psiParent: IShellItem; pszName: PCWSTR; pbc: IBindCtx; const riid: TGUID; out ppv): HResult;
    stdcall; external shell32_dll;
{$ENDIF}// (_WIN32_IE >= _WIN32_IE_IE70)

{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
function SHCreateItemInKnownFolder(const kfid: TKNOWNFOLDERID; dwKFFlags: DWORD; pszItem: PCWSTR; const riid: TGUID; out ppv): HResult;
    stdcall; external shell32_dll;
// get the IDList expression from an object, works with objects that support IPersistIDlist or IPersistIDlist like CLSID_ShellItem and most shell folders
function SHGetIDListFromObject(punk: IUnknown; out ppidl: PIDLIST_ABSOLUTE): HResult; stdcall; external shell32_dll;
// similar to SHGetIDListFromObject but returns an IShellItem-based object (preferred for performance if the IDList is already bound to a folder)
function SHGetItemFromObject(punk: IUnknown; const riid: TGUID; out ppv): HResult; stdcall; external shell32_dll;
// these APIs return object that support IPropertyStore or related interfaces
function SHGetPropertyStoreFromIDList(pidl: PCIDLIST_ABSOLUTE; flags: TGETPROPERTYSTOREFLAGS; const riid: TGUID; out ppv): HResult;
    stdcall; external shell32_dll;
function SHGetPropertyStoreFromParsingName(pszPath: PCWSTR; pbc: IBindCtx; flags: TGETPROPERTYSTOREFLAGS;
    const riid: TGUID; out ppv): HResult; stdcall; external shell32_dll;
function SHGetNameFromIDList(pidl: PCIDLIST_ABSOLUTE; sigdnName: TSIGDN; out ppszName: PWSTR): HResult; stdcall; external shell32_dll;
{$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)



{$IF  (NTDDI_VERSION >= NTDDI_WIN7)}
type
    TDATAOBJ_GET_ITEM_FLAGS = (
        DOGIF_DEFAULT = 0,
        DOGIF_TRAVERSE_LINK = $1,
        DOGIF_NO_HDROP = $2,
        DOGIF_NO_URL = $4,
        DOGIF_ONLY_IF_ONE = $8
        );
    PDATAOBJ_GET_ITEM_FLAGS = ^TDATAOBJ_GET_ITEM_FLAGS;

function SHGetItemFromDataObject(pdtobj: IDataObject; dwFlags: TDATAOBJ_GET_ITEM_FLAGS; const riid: TGUID; out ppv): HResult;
    stdcall; external shell32_dll;
{$ENDIF}// (NTDDI_VERSION >= NTDDI_WIN7)

const
    STR_GPS_HANDLERPROPERTIESONLY: WideString = 'GPS_HANDLERPROPERTIESONLY';
    STR_GPS_FASTPROPERTIESONLY: WideString = 'GPS_FASTPROPERTIESONLY';
    STR_GPS_OPENSLOWITEM: WideString = 'GPS_OPENSLOWITEM';
    STR_GPS_DELAYCREATION: WideString = 'GPS_DELAYCREATION';
    STR_GPS_BESTEFFORT: WideString = 'GPS_BESTEFFORT';
    STR_GPS_NO_OPLOCK: WideString = 'GPS_NO_OPLOCK';


type
    IUserAccountChangeCallback = interface(IUnknown)
        ['{a561e69a-b4b8-4113-91a5-64c6bcca3430}']
        function OnPictureChange(pszUserName: LPCWSTR): HResult; stdcall;
    end;


{$IF  (NTDDI_VERSION >= NTDDI_WINXP)}
type
    IEnumShellItems = interface(IUnknown)
        ['{70629033-e363-4a28-a567-0db78006e6d7}']
        function Next(celt: ULONG; out rgelt: PIShellItem; out pceltFetched: ULONG): HResult; stdcall;
        function Skip(celt: ULONG): HResult; stdcall;
        function Reset(): HResult; stdcall;
        function Clone(out ppenum: IEnumShellItems): HResult; stdcall;
    end;

    TSTGTRANSCONFIRMATION = TGUID;
    PSTGTRANSCONFIRMATION = ^TSTGTRANSCONFIRMATION;

    TSTGOP = (
        STGOP_MOVE = 1,
        STGOP_COPY = 2,
        STGOP_SYNC = 3,
        STGOP_REMOVE = 5,
        STGOP_RENAME = 6,
        STGOP_APPLYPROPERTIES = 8,
        STGOP_NEW = 10
        );

{$ENDIF}// NTDDI_WINXP


    TTRANSFER_SOURCE_FLAGS = (
        TSF_NORMAL = DWORD(0),
        TSF_FAIL_EXIST = 0,
        TSF_RENAME_EXIST = $1,
        TSF_OVERWRITE_EXIST = $2,
        TSF_ALLOW_DECRYPTION = $4,
        TSF_NO_SECURITY = $8,
        TSF_COPY_CREATION_TIME = $10,
        TSF_COPY_WRITE_TIME = $20,
        TSF_USE_FULL_ACCESS = $40,
        TSF_DELETE_RECYCLE_IF_POSSIBLE = $80,
        TSF_COPY_HARD_LINK = $100,
        TSF_COPY_LOCALIZED_NAME = $200,
        TSF_MOVE_AS_COPY_DELETE = $400,
        TSF_SUSPEND_SHELLEVENTS = $800
        );

{$IF  (_WIN32_IE >= _WIN32_IE_IE70)}

    TTRANSFER_ADVISE_STATE = (
        TS_NONE = DWORD(0),
        TS_PERFORMING = $1,
        TS_PREPARING = $2,
        TS_INDETERMINATE = $4
        );



    ITransferAdviseSink = interface(IUnknown)
        ['{d594d0d8-8da7-457b-b3b4-ce5dbaac0b88}']
        function UpdateProgress(ullSizeCurrent: ULONGLONG; ullSizeTotal: ULONGLONG; nFilesCurrent: int32;
            nFilesTotal: int32; nFoldersCurrent: int32; nFoldersTotal: int32): HResult; stdcall;
        function UpdateTransferState(ts: TTRANSFER_ADVISE_STATE): HResult; stdcall;
        function ConfirmOverwrite(psiSource: IShellItem; psiDestParent: IShellItem; pszName: LPCWSTR): HResult; stdcall;
        function ConfirmEncryptionLoss(psiSource: IShellItem): HResult; stdcall;
        function FileFailure(psi: IShellItem; pszItem: LPCWSTR; hrError: HRESULT; var pszRename: LPWSTR;
            cchRename: ULONG): HResult; stdcall;
        function SubStreamFailure(psi: IShellItem; pszStreamName: LPCWSTR; hrError: HRESULT): HResult; stdcall;
        function PropertyFailure(psi: IShellItem; const pkey: TPROPERTYKEY; hrError: HRESULT): HResult; stdcall;
    end;


{$ENDIF}// (_WIN32_IE >= _WIN32_IE_IE70)




 {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}




    ITransferSource = interface(IUnknown)
        ['{00adb003-bde9-45c6-8e29-d09f9353e108}']
        function Advise(psink: ITransferAdviseSink; out pdwCookie: DWORD): HResult; stdcall;
        function Unadvise(dwCookie: DWORD): HResult; stdcall;
        function SetProperties(pproparray: IPropertyChangeArray): HResult; stdcall;
        function OpenItem(psi: IShellItem; flags: TTRANSFER_SOURCE_FLAGS; const riid: TGUID; out ppv): HResult; stdcall;
        function MoveItem(psi: IShellItem; psiParentDst: IShellItem; pszNameDst: LPCWSTR; flags: TTRANSFER_SOURCE_FLAGS;
            out ppsiNew: IShellItem): HResult; stdcall;
        function RecycleItem(psiSource: IShellItem; psiParentDest: IShellItem; flags: TTRANSFER_SOURCE_FLAGS;
            out ppsiNewDest: IShellItem): HResult; stdcall;
        function RemoveItem(psiSource: IShellItem; flags: TTRANSFER_SOURCE_FLAGS): HResult; stdcall;
        function RenameItem(psiSource: IShellItem; pszNewName: LPCWSTR; flags: TTRANSFER_SOURCE_FLAGS;
            out ppsiNewDest: IShellItem): HResult; stdcall;
        function LinkItem(psiSource: IShellItem; psiParentDest: IShellItem; pszNewName: LPCWSTR;
            flags: TTRANSFER_SOURCE_FLAGS; out ppsiNewDest: IShellItem): HResult; stdcall;
        function ApplyPropertiesToItem(psiSource: IShellItem; out ppsiNew: IShellItem): HResult; stdcall;
        function GetDefaultDestinationName(psiSource: IShellItem; psiParentDest: IShellItem;
            out ppszDestinationName: LPWSTR): HResult; stdcall;
        function EnterFolder(psiChildFolderDest: IShellItem): HResult; stdcall;
        function LeaveFolder(psiChildFolderDest: IShellItem): HResult; stdcall;
    end;


{$ENDIF}// _WIN32_IE_IE70




    TSHELL_ITEM_RESOURCE = record
        guidType: TGUID;
        szName: array [0.. 259] of WCHAR;
    end;




    IEnumResources = interface(IUnknown)
        ['{2dd81fe3-a83c-4da9-a330-47249d345ba1}']
        function Next(celt: ULONG; out psir: PSHELL_ITEM_RESOURCE; out pceltFetched: ULONG): HResult; stdcall;
        function Skip(celt: ULONG): HResult; stdcall;
        function Reset(): HResult; stdcall;
        function Clone(out ppenumr: IEnumResources): HResult; stdcall;
    end;



    IShellItemResources = interface(IUnknown)
        ['{ff5693be-2ce0-4d48-b5c5-40817d1acdb9}']
        function GetAttributes(out pdwAttributes: DWORD): HResult; stdcall;
        function GetSize(out pullSize: ULONGLONG): HResult; stdcall;
        function GetTimes(out pftCreation: TFILETIME; out pftWrite: TFILETIME; out pftAccess: TFILETIME): HResult; stdcall;
        function SetTimes(const pftCreation: TFILETIME; const pftWrite: TFILETIME; const pftAccess: TFILETIME): HResult; stdcall;
        function GetResourceDescription(const pcsir: TSHELL_ITEM_RESOURCE; out ppszDescription: LPWSTR): HResult; stdcall;
        function EnumResources(out ppenumr: IEnumResources): HResult; stdcall;
        function SupportsResource(const pcsir: TSHELL_ITEM_RESOURCE): HResult; stdcall;
        function OpenResource(const pcsir: TSHELL_ITEM_RESOURCE; const riid: TGUID; out ppv): HResult; stdcall;
        function CreateResource(const pcsir: TSHELL_ITEM_RESOURCE; const riid: TGUID; out ppv): HResult; stdcall;
        function MarkForDelete(): HResult; stdcall;
    end;



    ITransferDestination = interface(IUnknown)
        ['{48addd32-3ca5-4124-abe3-b5a72531b207}']
        function Advise(psink: ITransferAdviseSink; out pdwCookie: DWORD): HResult; stdcall;
        function Unadvise(dwCookie: DWORD): HResult; stdcall;
        function CreateItem(pszName: LPCWSTR; dwAttributes: DWORD; ullSize: ULONGLONG; flags: TTRANSFER_SOURCE_FLAGS;
            const riidItem: TGUID; out ppvItem; const riidResources: TGUID; out ppvResources): HResult; stdcall;
    end;




    TOVERLAPPED = record
        Internal: ULONG_PTR;
        InternalHigh: ULONG_PTR;
        case integer of
            0: (
                Offset: DWORD;
                OffsetHigh: DWORD;
                hEvent: HANDLE;
            );
            1: (APointer: POinter);
    end;

    POVERLAPPED = ^TOVERLAPPED;


    IStreamAsync = interface(IStream)
        ['{fe0b6665-e0ca-49b9-a178-2b5cb48d92a5}']
        function ReadAsync(out pv: PByte; cb: DWORD; out pcbRead: PDWORD; lpOverlapped: POVERLAPPED): HResult; stdcall;
        function WriteAsync(lpBuffer: PByte; cb: DWORD; out pcbWritten: PDWORD; lpOverlapped: POVERLAPPED): HResult; stdcall;
        function OverlappedResult(lpOverlapped: POVERLAPPED; out lpNumberOfBytesTransferred: PDWORD; bWait: boolean): HResult; stdcall;
        function CancelIo(): HResult; stdcall;
    end;




    IStreamUnbufferedInfo = interface(IUnknown)
        ['{8a68fdda-1fdc-4c20-8ceb-416643b5a625}']
        function GetSectorSize(out pcbSectorSize: ULONG): HResult; stdcall;

    end;

 {$IF  (_WIN32_IE >= _WIN32_IE_IE70)}
    IFileOperationProgressSink = interface(IUnknown)
        ['{04b0f1a7-9490-44bc-96e1-4296a31252e2}']
        function StartOperations(): HResult; stdcall;
        function FinishOperations(hrResult: HRESULT): HResult; stdcall;
        function PreRenameItem(dwFlags: DWORD; psiItem: IShellItem; pszNewName: LPCWSTR): HResult; stdcall;
        function PostRenameItem(dwFlags: DWORD; psiItem: IShellItem; pszNewName: LPCWSTR; hrRename: HRESULT;
            psiNewlyCreated: IShellItem): HResult; stdcall;
        function PreMoveItem(dwFlags: DWORD; psiItem: IShellItem; psiDestinationFolder: IShellItem; pszNewName: LPCWSTR): HResult; stdcall;
        function PostMoveItem(dwFlags: DWORD; psiItem: IShellItem; psiDestinationFolder: IShellItem;
            pszNewName: LPCWSTR; hrMove: HRESULT; psiNewlyCreated: IShellItem): HResult; stdcall;
        function PreCopyItem(dwFlags: DWORD; psiItem: IShellItem; psiDestinationFolder: IShellItem; pszNewName: LPCWSTR): HResult; stdcall;
        function PostCopyItem(dwFlags: DWORD; psiItem: IShellItem; psiDestinationFolder: IShellItem;
            pszNewName: LPCWSTR; hrCopy: HRESULT; psiNewlyCreated: IShellItem): HResult; stdcall;
        function PreDeleteItem(dwFlags: DWORD; psiItem: IShellItem): HResult; stdcall;
        function PostDeleteItem(dwFlags: DWORD; psiItem: IShellItem; hrDelete: HRESULT; psiNewlyCreated: IShellItem): HResult; stdcall;
        function PreNewItem(dwFlags: DWORD; psiDestinationFolder: IShellItem; pszNewName: LPCWSTR): HResult; stdcall;
        function PostNewItem(dwFlags: DWORD; psiDestinationFolder: IShellItem; pszNewName: LPCWSTR;
            pszTemplateName: LPCWSTR; dwFileAttributes: DWORD; hrNew: HRESULT; psiNewItem: IShellItem): HResult; stdcall;
        function UpdateProgress(iWorkTotal: UINT; iWorkSoFar: UINT): HResult; stdcall;
        function ResetTimer(): HResult; stdcall;
        function PauseTimer(): HResult; stdcall;
        function ResumeTimer(): HResult; stdcall;
    end;

{$ENDIF}// (_WIN32_IE >= _WIN32_IE_IE70)




{$IF  (_WIN32_IE >= _WIN32_IE_IE70)}
function SHCreateShellItemArray(pidlParent: PCIDLIST_ABSOLUTE; psf: IShellFolder; cidl: UINT; ppidl: PCUITEMID_CHILD_ARRAY;
    out ppsiItemArray: IShellItemArray): HResult; stdcall; external shell32_dll;
function SHCreateShellItemArrayFromDataObject(pdo: IDataObject; const riid: TGUID; out ppv): HResult; stdcall; external shell32_dll;
function SHCreateShellItemArrayFromIDLists(cidl: UINT; rgpidl: PCIDLIST_ABSOLUTE_ARRAY; out ppsiItemArray: IShellItemArray): HResult;
    stdcall; external shell32_dll;
function SHCreateShellItemArrayFromShellItem(psi: IShellItem; const riid: TGUID; out ppv): HResult; stdcall; external shell32_dll;
{$ENDIF}// (_WIN32_IE >= _WIN32_IE_IE70)




type
    IInitializeWithItem = interface(IUnknown)
        ['{7f73be3f-fb79-493c-a6c7-7ee14e245841}']
        function Initialize(psi: IShellItem; grfMode: DWORD): HResult; stdcall;
    end;



    IObjectWithSelection = interface(IUnknown)
        ['{1c9cd5bb-98e9-4491-a60f-31aacc72b83c}']
        function SetSelection(psia: IShellItemArray): HResult; stdcall;
        function GetSelection(const riid: TGUID; out ppv): HResult; stdcall;
    end;




    IObjectWithBackReferences = interface(IUnknown)
        ['{321a6a6a-d61f-4bf3-97ae-14be2986bb36}']
        function RemoveBackReferences(): HResult; stdcall;
    end;

    TPROPERTYUI_NAME_FLAGS = (
        PUIFNF_DEFAULT = DWORD(0),
        PUIFNF_MNEMONIC = $1
        );


    TPROPERTYUI_FLAGS = (
        PUIF_DEFAULT = DWORD(0),
        PUIF_RIGHTALIGN = $1,
        PUIF_NOLABELININFOTIP = $2
        );

    TPROPERTYUI_FORMAT_FLAGS = (
        PUIFFDF_DEFAULT = DWORD(0),
        PUIFFDF_RIGHTTOLEFT = $1,
        PUIFFDF_SHORTFORMAT = $2,
        PUIFFDF_NOTIME = $4,
        PUIFFDF_FRIENDLYDATE = $8
        );




    IPropertyUI = interface(IUnknown)
        ['{757a7d9f-919a-4118-99d7-dbb208c8cc66}']
        function ParsePropertyName(pszName: LPCWSTR; out pfmtid: TFMTID; out ppid: TPROPID; var pchEaten: ULONG): HResult; stdcall;
        function GetCannonicalName(fmtid: TREFFMTID; pid: TPROPID; pwszText: LPWSTR; cchText: DWORD): HResult; stdcall;
        function GetDisplayName(fmtid: REFFMTID; pid: PROPID; flags: TPROPERTYUI_NAME_FLAGS; pwszText: LPWSTR;
            cchText: DWORD): HResult; stdcall;
        function GetPropertyDescription(fmtid: REFFMTID; pid: PROPID; out pwszText: LPWSTR; cchText: DWORD): HResult; stdcall;
        function GetDefaultWidth(fmtid: REFFMTID; pid: PROPID; out pcxChars: ULONG): HResult; stdcall;
        function GetFlags(fmtid: REFFMTID; pid: PROPID; out pflags: TPROPERTYUI_FLAGS): HResult; stdcall;
        function FormatForDisplay(fmtid: REFFMTID; pid: TPROPID; const ppropvar: TPROPVARIANT; puiff: TPROPERTYUI_FORMAT_FLAGS;
            out pwszText: LPWSTR; cchText: DWORD): HResult; stdcall;
        function GetHelpInfo(fmtid: TREFFMTID; pid: TPROPID; out pwszHelpFile: LPWSTR; cch: DWORD; out puHelpID: UINT): HResult; stdcall;
    end;




{$IF  (_WIN32_IE >= _WIN32_IE_IE70)}
function SHRemovePersonalPropertyValues(psia: IShellItemArray): HResult; stdcall; external shell32_dll;
function SHAddDefaultPropertiesByExt(pszExt: PCWSTR; pPropStore: IPropertyStore): HResult; stdcall; external shell32_dll;
function SHCreateDefaultPropertiesOp(psi: IShellItem; out ppFileOp: IFileOperation): HResult; stdcall; external shell32_dll;
function SHSetDefaultProperties(hwnd: HWND; psi: IShellItem; dwFileOpFlags: DWORD; pfops: IFileOperationProgressSink): HResult;
    stdcall; external shell32_dll;
{$ENDIF}// (_WIN32_IE >= _WIN32_IE_IE70)



type
    ICategoryProvider = interface(IUnknown)
        ['{9af64809-5864-4c26-a720-c1f78c086ee3}']
        function CanCategorizeOnSCID(const pscid: TSHCOLUMNID): HResult; stdcall;
        function GetDefaultCategory(out pguid: TGUID; out pscid: TSHCOLUMNID): HResult; stdcall;
        function GetCategoryForSCID(const pscid: TSHCOLUMNID; out pguid: TGUID): HResult; stdcall;
        function EnumCategories(out penum: IEnumGUID): HResult; stdcall;
        function GetCategoryName(const pguid: TGUID; out pszName: LPWSTR; cch: UINT): HResult; stdcall;
        function CreateCategory(const pguid: TGUID; const riid: TGUID; out ppv): HResult; stdcall;
    end;




    TCATEGORYINFO_FLAGS = (
        CATINFO_NORMAL = 0,
        CATINFO_COLLAPSED = $1,
        CATINFO_HIDDEN = $2,
        CATINFO_EXPANDED = $4,
        CATINFO_NOHEADER = $8,
        CATINFO_NOTCOLLAPSIBLE = $10,
        CATINFO_NOHEADERCOUNT = $20,
        CATINFO_SUBSETTED = $40,
        CATINFO_SEPARATE_IMAGES = $80,
        CATINFO_SHOWEMPTY = $100
        );

    TCATSORT_FLAGS = (
        CATSORT_DEFAULT = 0,
        CATSORT_NAME = $1
        );

    TCATEGORY_INFO = record
        cif: TCATEGORYINFO_FLAGS;
        wszName: array [0..259] of WCHAR;
    end;



    ICategorizer = interface(IUnknown)
        ['{a3b14589-9174-49a8-89a3-06a1ae2b9ba7}']
        function GetDescription(out pszDesc: LPWSTR; cch: UINT): HResult; stdcall;
        function GetCategory(cidl: UINT; apidl: PCUITEMID_CHILD_ARRAY; out rgCategoryIds: PDWORD): HResult; stdcall;
        function GetCategoryInfo(dwCategoryId: DWORD; out pci: TCATEGORY_INFO): HResult; stdcall;
        function CompareCategory(csfFlags: TCATSORT_FLAGS; dwCategoryId1: DWORD; dwCategoryId2: DWORD): HResult; stdcall;
    end;




{$IF  (NTDDI_VERSION >= NTDDI_WIN2K)}

//include <pshpack8.h>
{$A8}
type
    TSHDRAGIMAGE = record
        sizeDragImage: TSIZE;
        ptOffset: TPOINT;
        hbmpDragImage: HBITMAP;
        crColorKey: TCOLORREF;
    end;

    PSHDRAGIMAGE = ^TSHDRAGIMAGE;

    //include <poppack.h> // Return to byte packing
{$A4}

    IDropTargetHelper = interface(IUnknown)
        ['{4657278B-411B-11D2-839A-00C04FD918D0}']
        function DragEnter(hwndTarget: HWND; pDataObject: IDataObject; ppt: PPOINT; dwEffect: DWORD): HResult; stdcall;
        function DragLeave(): HResult; stdcall;
        function DragOver(ppt: PPOINT; dwEffect: DWORD): HResult; stdcall;
        function Drop(pDataObject: IDataObject; ppt: PPOINT; dwEffect: DWORD): HResult; stdcall;
        function Show(fShow: boolean): HResult; stdcall;
    end;


    IDragSourceHelper = interface(IUnknown)
        ['{DE5BF786-477A-11D2-839D-00C04FD918D0}']
        function InitializeFromBitmap(pshdi: PSHDRAGIMAGE; pDataObject: IDataObject): HResult; stdcall;
        function InitializeFromWindow(hwnd: HWND; ppt: PPOINT; pDataObject: IDataObject): HResult; stdcall;
    end;


{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    TDSH_FLAGS = (
        DSH_ALLOWDROPDESCRIPTIONTEXT = $1
        );

    IDragSourceHelper2 = interface(IDragSourceHelper)
        ['{83E07D0D-0C5F-4163-BF1A-60B274051E40}']
        function SetFlags(dwFlags: DWORD): HResult; stdcall;

    end;

{$ENDIF}// NTDDI_VISTA

{$ENDIF}// NTDDI_WIN2K

type
    TSLR_FLAGS = (
        SLR_NONE = 0,
        SLR_NO_UI = $1,
        SLR_ANY_MATCH = $2,
        SLR_UPDATE = $4,
        SLR_NOUPDATE = $8,
        SLR_NOSEARCH = $10,
        SLR_NOTRACK = $20,
        SLR_NOLINKINFO = $40,
        SLR_INVOKE_MSI = $80,
        SLR_NO_UI_WITH_MSG_PUMP = $101,
        SLR_OFFER_DELETE_WITHOUT_FILE = $200,
        SLR_KNOWNFOLDER = $400,
        SLR_MACHINE_IN_LOCAL_TARGET = $800,
        SLR_UPDATE_MACHINE_AND_SID = $1000,
        SLR_NO_OBJECT_ID = $2000
        );


    TSLGP_FLAGS = (
        SLGP_SHORTPATH = $1,
        SLGP_UNCPRIORITY = $2,
        SLGP_RAWPATH = $4,
        SLGP_RELATIVEPRIORITY = $8
        );



    IShellLinkA = interface(IUnknown)
        ['{000214EE-0000-0000-C000-000000000046}']
        function GetPath(out pszFile: LPSTR; cch: int32; var pfd: TWIN32_FIND_DATAA; fFlags: DWORD): HResult; stdcall;
        function GetIDList(out ppidl: PIDLIST_ABSOLUTE): HResult; stdcall;
        function SetIDList(pidl: PCIDLIST_ABSOLUTE): HResult; stdcall;
        function GetDescription(out pszName: LPSTR; cch: int32): HResult; stdcall;
        function SetDescription(pszName: LPCSTR): HResult; stdcall;
        function GetWorkingDirectory(out pszDir: LPSTR; cch: int32): HResult; stdcall;
        function SetWorkingDirectory(pszDir: LPCSTR): HResult; stdcall;
        function GetArguments(out pszArgs: LPSTR; cch: int32): HResult; stdcall;
        function SetArguments(pszArgs: LPCSTR): HResult; stdcall;
        function GetHotkey(out pwHotkey: word): HResult; stdcall;
        function SetHotkey(wHotkey: word): HResult; stdcall;
        function GetShowCmd(out piShowCmd: int32): HResult; stdcall;
        function SetShowCmd(iShowCmd: int32): HResult; stdcall;
        function GetIconLocation(out pszIconPath: LPSTR; cch: int32; out piIcon: int32): HResult; stdcall;
        function SetIconLocation(pszIconPath: LPCSTR; iIcon: int32): HResult; stdcall;
        function SetRelativePath(pszPathRel: LPCSTR; dwReserved: DWORD): HResult; stdcall;
        function Resolve(hwnd: HWND; fFlags: DWORD): HResult; stdcall;
        function SetPath(pszFile: LPCSTR): HResult; stdcall;
    end;




    IShellLinkDataList = interface(IUnknown)
        ['{45e2b4ae-b1c3-11d0-b92f-00a0c90312e1}']
        function AddDataBlock(pDataBlock: PByte): HResult; stdcall;
        function CopyDataBlock(dwSig: DWORD; out ppDataBlock: PByte): HResult; stdcall;
        function RemoveDataBlock(dwSig: DWORD): HResult; stdcall;
        function GetFlags(out pdwFlags: DWORD): HResult; stdcall;
        function SetFlags(dwFlags: DWORD): HResult; stdcall;
    end;


{$IF  (NTDDI_VERSION >= NTDDI_WIN2K)}
    IResolveShellLink = interface(IUnknown)
        ['{5cd52983-9449-11d2-963a-00c04f79adf0}']
        function ResolveShellLink(punkLink: IUnknown; hwnd: HWND; fFlags: DWORD): HResult; stdcall;
    end;

{$ENDIF}// NTDDI_WIN2K

    TSPINITF = (
        SPINITF_NORMAL = DWORD(0),
        SPINITF_MODAL = $1,
        SPINITF_NOMINIMIZE = $8
        );




    IActionProgressDialog = interface(IUnknown)
        ['{49ff1172-eadc-446d-9285-156453a6431c}']
        function Initialize(flags: TSPINITF; pszTitle: LPCWSTR; pszCancel: LPCWSTR): HResult; stdcall;
        function Stop(): HResult; stdcall;
    end;




    IHWEventHandler = interface(IUnknown)
        ['{C1FB73D0-EC3A-4ba2-B512-8CDB9187B6D1}']
        function Initialize(pszParams: LPCWSTR): HResult; stdcall;
        function HandleEvent(pszDeviceID: LPCWSTR; pszAltDeviceID: LPCWSTR; pszEventType: LPCWSTR): HResult; stdcall;
        function HandleEventWithContent(pszDeviceID: LPCWSTR; pszAltDeviceID: LPCWSTR; pszEventType: LPCWSTR;
            pszContentTypeHandler: LPCWSTR; pdataobject: IDataObject): HResult; stdcall;
    end;


    IHWEventHandler2 = interface(IHWEventHandler)
        ['{CFCC809F-295D-42e8-9FFC-424B33C487E6}']
        function HandleEventWithHWND(pszDeviceID: LPCWSTR; pszAltDeviceID: LPCWSTR; pszEventType: LPCWSTR;
            hwndOwner: HWND): HResult; stdcall;

    end;


const
    ARCONTENT_AUTORUNINF = $00000002;   // That's the one we have today, and always had
    ARCONTENT_AUDIOCD = $00000004;   // Audio CD (not MP3 and the like, the stuff you buy at the store)
    ARCONTENT_DVDMOVIE = $00000008;  // DVD Movie (not MPEGs, the stuff you buy at the store)
    ARCONTENT_BLANKCD = $00000010;  // Blank CD-R/CD-RW)
    ARCONTENT_BLANKDVD = $00000020;  // Blank DVD-R/DVD-RW
    ARCONTENT_UNKNOWNCONTENT = $00000040;  // Whatever files.  Mean that it's formatted.
    ARCONTENT_AUTOPLAYPIX = $00000080;  // Any files classified by shell as image. (jpg, bmp, etc.)
    ARCONTENT_AUTOPLAYMUSIC = $00000100;  // Any files classified by shell as music. (wma, mp3, etc.)
    ARCONTENT_AUTOPLAYVIDEO = $00000200;  // Any files classified by shell as video. (mpg, avi, etc.)
{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    ARCONTENT_VCD = $00000400;  // VCD format
    ARCONTENT_SVCD = $00000800;  // Super-VCD format
    ARCONTENT_DVDAUDIO = $00001000;  // DVD-Audio
    ARCONTENT_BLANKBD = $00002000;  // Blank BD-R/BD-RW
    ARCONTENT_BLURAY = $00004000;  // Blu-ray Disc
    ARCONTENT_CAMERASTORAGE = $00008000;  // Camera Storage
    ARCONTENT_CUSTOMEVENT = $00010000;  // Custom Event
    ARCONTENT_NONE = $00000000;  // Empty (but formatted)
    ARCONTENT_MASK = $0001FFFE;  // Bits that denote valid content types
    ARCONTENT_PHASE_UNKNOWN = $00000000;  // We can be in any phase.  This is XP behavior.
    ARCONTENT_PHASE_PRESNIFF = $10000000;  // These are contents we know w/o scanning the media for complete data (e.g. Audio track, DVD Movie).
    ARCONTENT_PHASE_SNIFFING = $20000000;
    // We are in the middle of searching the media.  There could be more contents to be found than currently reported.
    ARCONTENT_PHASE_FINAL = $40000000;  // We have finished searching; contents we report are final.
    ARCONTENT_PHASE_MASK = $70000000;  // Bits that denote what phase we are in the Autoplay process.
{$ENDIF}// NTDDI_VISTA


type
    IQueryCancelAutoPlay = interface(IUnknown)
        ['{DDEFE873-6997-4e68-BE26-39B633ADBE12}']
        function AllowAutoPlay(pszPath: LPCWSTR; dwContentType: DWORD; pszLabel: LPCWSTR; dwSerialNumber: DWORD): HResult; stdcall;
    end;



{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    IDynamicHWHandler = interface(IUnknown)
        ['{DC2601D7-059E-42fc-A09D-2AFD21B6D5F7}']
        function GetDynamicInfo(pszDeviceID: LPCWSTR; dwContentTyp: DWORD; out ppszAction: LPWSTR): HResult; stdcall;
    end;

{$ENDIF}// NTDDI_VISTA


    TSPBEGINF = (
        SPBEGINF_NORMAL = DWORD(0),
        SPBEGINF_AUTOTIME = $2,
        SPBEGINF_NOPROGRESSBAR = $10,
        SPBEGINF_MARQUEEPROGRESS = $20,
        SPBEGINF_NOCANCELBUTTON = $40
        );


    TSPACTION = (
        SPACTION_NONE = 0,
        SPACTION_MOVING = (SPACTION_NONE + 1),
        SPACTION_COPYING = (SPACTION_MOVING + 1),
        SPACTION_RECYCLING = (SPACTION_COPYING + 1),
        SPACTION_APPLYINGATTRIBS = (SPACTION_RECYCLING + 1),
        SPACTION_DOWNLOADING = (SPACTION_APPLYINGATTRIBS + 1),
        SPACTION_SEARCHING_INTERNET = (SPACTION_DOWNLOADING + 1),
        SPACTION_CALCULATING = (SPACTION_SEARCHING_INTERNET + 1),
        SPACTION_UPLOADING = (SPACTION_CALCULATING + 1),
        SPACTION_SEARCHING_FILES = (SPACTION_UPLOADING + 1),
        SPACTION_DELETING = (SPACTION_SEARCHING_FILES + 1),
        SPACTION_RENAMING = (SPACTION_DELETING + 1),
        SPACTION_FORMATTING = (SPACTION_RENAMING + 1),
        SPACTION_COPY_MOVING = (SPACTION_FORMATTING + 1)
        );

    TSPTEXT = (
        SPTEXT_ACTIONDESCRIPTION = 1,
        SPTEXT_ACTIONDETAIL = (SPTEXT_ACTIONDESCRIPTION + 1)
        );




    IActionProgress = interface(IUnknown)
        ['{49ff1173-eadc-446d-9285-156453a6431c}']
        function _Begin(action: TSPACTION; flags: TSPBEGINF): HResult; stdcall;
        function UpdateProgress(ulCompleted: ULONGLONG; ulTotal: ULONGLONG): HResult; stdcall;
        function UpdateText(sptext: TSPTEXT; pszText: LPCWSTR; fMayCompact: boolean): HResult; stdcall;
        function QueryCancel(out pfCancelled: boolean): HResult; stdcall;
        function ResetCancel(): HResult; stdcall;
        function _End(): HResult; stdcall;
    end;




    IShellExtInit = interface(IUnknown)
        ['{000214E8-0000-0000-C000-000000000046}']
        function Initialize(pidlFolder: PCIDLIST_ABSOLUTE; pdtobj: IDataObject; hkeyProgID: HKEY): HResult; stdcall;
    end;


    PIShellExtInit = ^IShellExtInit;



    TEXPPS = (
        EXPPS_FILETYPES = UINT($1)
        );


    IShellPropSheetExt = interface(IUnknown)
        ['{000214E9-0000-0000-C000-000000000046}']
        function AddPages(pfnAddPage: PFNSVADDPROPSHEETPAGE; lParam: LPARAM): HResult; stdcall;
        function ReplacePage(uPageID: TEXPPS; pfnReplaceWith: PFNSVADDPROPSHEETPAGE; lParam: LPARAM): HResult; stdcall;
    end;


    PIShellPropSheetExt = ^IShellPropSheetExt;


    IRemoteComputer = interface(IUnknown)
        ['{000214FE-0000-0000-C000-000000000046}']
        function Initialize(pszMachine: LPCWSTR; bEnumerating: boolean): HResult; stdcall;
    end;

    IObjectWithCancelEvent = interface(IUnknown)
        ['{F279B885-0AE9-4b85-AC06-DDECF9408941}']
        function GetCancelEvent(out phEvent: HANDLE): HResult; stdcall;
    end;


    IUserNotification = interface(IUnknown)
        ['{ba9711ba-5893-4787-a7e1-41277151550b}']
        function SetBalloonInfo(pszTitle: LPCWSTR; pszText: LPCWSTR; dwInfoFlags: DWORD): HResult; stdcall;
        function SetBalloonRetry(dwShowTime: DWORD; dwInterval: DWORD; cRetryCount: UINT): HResult; stdcall;
        function SetIconInfo(hIcon: HICON; pszToolTip: LPCWSTR): HResult; stdcall;
        function Show(pqc: IQueryContinue; dwContinuePollInterval: DWORD): HResult; stdcall;
        function PlaySound(pszSoundName: LPCWSTR): HResult; stdcall;
    end;


    IUserNotificationCallback = interface(IUnknown)
        ['{19108294-0441-4AFF-8013-FA0A730B0BEA}']
        function OnBalloonUserClick(pt: PPOINT): HResult; stdcall;
        function OnLeftClick(pt: PPOINT): HResult; stdcall;
        function OnContextMenu(pt: PPOINT): HResult; stdcall;
    end;




    IUserNotification2 = interface(IUnknown)
        ['{215913CC-57EB-4FAB-AB5A-E5FA7BEA2A6C}']
        function SetBalloonInfo(pszTitle: LPCWSTR; pszText: LPCWSTR; dwInfoFlags: DWORD): HResult; stdcall;
        function SetBalloonRetry(dwShowTime: DWORD; dwInterval: DWORD; cRetryCount: UINT): HResult; stdcall;
        function SetIconInfo(hIcon: HICON; pszToolTip: LPCWSTR): HResult; stdcall;
        function Show(pqc: IQueryContinue; dwContinuePollInterval: DWORD; pSink: IUserNotificationCallback): HResult; stdcall;
        function PlaySound(pszSoundName: LPCWSTR): HResult; stdcall;
    end;



    IItemNameLimits = interface(IUnknown)
        ['{1df0d7f1-b267-4d28-8b10-12e23202a5c4}']
        function GetValidCharacters(out ppwszValidChars: LPWSTR; out ppwszInvalidChars: LPWSTR): HResult; stdcall;
        function GetMaxLength(pszName: LPCWSTR; out piMaxNameLen: int32): HResult; stdcall;
    end;



{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}

    ISearchFolderItemFactory = interface(IUnknown)
        ['{a0ffbc28-5482-4366-be27-3e81e78e06c2}']
        function SetDisplayName(pszDisplayName: LPCWSTR): HResult; stdcall;
        function SetFolderTypeID(ftid: TFOLDERTYPEID): HResult; stdcall;
        function SetFolderLogicalViewMode(flvm: TFOLDERLOGICALVIEWMODE): HResult; stdcall;
        function SetIconSize(iIconSize: int32): HResult; stdcall;
        function SetVisibleColumns(cVisibleColumns: UINT; rgKey: PPROPERTYKEY): HResult; stdcall;
        function SetSortColumns(cSortColumns: UINT; rgSortColumns: PSORTCOLUMN): HResult; stdcall;
        function SetGroupColumn(const keyGroup: TPROPERTYKEY): HResult; stdcall;
        function SetStacks(cStackKeys: UINT; rgStackKeys: PPROPERTYKEY): HResult; stdcall;
        function SetScope(psiaScope: IShellItemArray): HResult; stdcall;
        function SetCondition(pCondition: ICondition): HResult; stdcall;
        function GetShellItem(const riid: TGUID; out ppv): HResult; stdcall;
        function GetIDList(out ppidl: PIDLIST_ABSOLUTE): HResult; stdcall;
    end;

{$ENDIF}// NTDDI_VISTA

const
    IEI_PRIORITY_MAX = ITSAT_MAX_PRIORITY;
    IEI_PRIORITY_MIN = ITSAT_MIN_PRIORITY;
    IEIT_PRIORITY_NORMAL = ITSAT_DEFAULT_PRIORITY;
    IEIFLAG_ASYNC = $0001;     // (deprecated) ask the extractor if it supports ASYNC extract (free threaded)
    IEIFLAG_CACHE = $0002;     // returned from the extractor if it does NOT cache the thumbnail
    IEIFLAG_ASPECT = $0004;     // passed to the extractor to beg it to render to the aspect ratio of the supplied rect
    IEIFLAG_OFFLINE = $0008;     // if the extractor shouldn't hit the net to get any content neede for the rendering
    IEIFLAG_GLEAM = $0010;     // does the image have a gleam ? this will be returned if it does
    IEIFLAG_SCREEN = $0020;     // render as if for the screen  (this is exlusive with IEIFLAG_ASPECT )
    IEIFLAG_ORIGSIZE = $0040;     // render to the approx size passed, but crop if neccessary
    IEIFLAG_NOSTAMP = $0080;     // returned from the extractor if it does NOT want an icon stamp on the thumbnail
    IEIFLAG_NOBORDER = $0100;     // returned from the extractor if it does NOT want an a border around the thumbnail
    IEIFLAG_QUALITY = $0200;     // passed to the Extract method to indicate that a slower, higher quality image is desired, re-compute the thumbnail
    IEIFLAG_REFRESH = $0400;     // returned from the extractor if it would like to have Refresh Thumbnail available




type


    IExtractImage = interface(IUnknown)
        ['{BB2E617C-0920-11d1-9A0B-00C04FC2D6C1}']
        function GetLocation(out pszPathBuffer: LPWSTR; cch: DWORD; var pdwPriority: DWORD; const prgSize: TSIZE;
            dwRecClrDepth: DWORD; var pdwFlags: DWORD): HResult; stdcall;
        function Extract(out phBmpThumbnail: HBITMAP): HResult; stdcall;
    end;

    PIExtractImage = ^IExtractImage;


    IExtractImage2 = interface(IExtractImage)
        ['{953BB1EE-93B4-11d1-98A3-00C04FB687DA}']
        function GetDateStamp(out pDateStamp: TFILETIME): HResult; stdcall;
    end;

    PIExtractImage2 = ^IExtractImage2;


    IThumbnailHandlerFactory = interface(IUnknown)
        ['{e35b4b2e-00da-4bc1-9f13-38bc11f5d417}']
        function GetThumbnailHandler(pidlChild: PCUITEMID_CHILD; pbc: IBindCtx; const riid: TGUID; out ppv): HResult; stdcall;
    end;


    IParentAndItem = interface(IUnknown)
        ['{b3a4b685-b685-4805-99d9-5dead2873236}']
        function SetParentAndItem(pidlParent: PCIDLIST_ABSOLUTE; psf: IShellFolder; pidlChild: PCUITEMID_CHILD): HResult; stdcall;
        function GetParentAndItem(out ppidlParent: PIDLIST_ABSOLUTE; out ppsf: IShellFolder;
            out ppidlChild: PITEMID_CHILD): HResult; stdcall;
    end;


    IDockingWindow = interface(IOleWindow)
        ['{012dd920-7b26-11d0-8ca9-00a0c92dbfe8}']
        function ShowDW(fShow: boolean): HResult; stdcall;
        function CloseDW(dwReserved: DWORD): HResult; stdcall;
        function ResizeBorderDW(prcBorder: PCRECT; punkToolbarSite: IUnknown; fReserved: boolean): HResult; stdcall;
    end;


const
    DBIM_MINSIZE = $0001;
    DBIM_MAXSIZE = $0002;
    DBIM_INTEGRAL = $0004;
    DBIM_ACTUAL = $0008;
    DBIM_TITLE = $0010;
    DBIM_MODEFLAGS = $0020;
    DBIM_BKCOLOR = $0040;
//include <pshpack8.h>
{$A8}
type
    TDESKBANDINFO = record
        dwMask: DWORD;
        ptMinSize: POINTL;
        ptMaxSize: POINTL;
        ptIntegral: POINTL;
        ptActual: POINTL;
        wszTitle: array [0.. 255] of WCHAR;
        dwModeFlags: DWORD;
        crBkgnd: TCOLORREF;
    end;

//include <poppack.h>
{$A4}
const
    DBIMF_NORMAL = $0000;
    DBIMF_FIXED = $0001;
    DBIMF_FIXEDBMP = $0004;  // a fixed background bitmap (if supported)
    DBIMF_VARIABLEHEIGHT = $0008;
    DBIMF_UNDELETEABLE = $0010;
    DBIMF_DEBOSSED = $0020;
    DBIMF_BKCOLOR = $0040;
    DBIMF_USECHEVRON = $0080;
    DBIMF_BREAK = $0100;
    DBIMF_ADDTOFRONT = $0200;
    DBIMF_TOPALIGN = $0400;
{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    DBIMF_NOGRIPPER = $0800;
    DBIMF_ALWAYSGRIPPER = $1000;
    DBIMF_NOMARGINS = $2000;
{$ENDIF}// NTDDI_VISTA
    DBIF_VIEWMODE_NORMAL = $0000;
    DBIF_VIEWMODE_VERTICAL = $0001;
    DBIF_VIEWMODE_FLOATING = $0002;
    DBIF_VIEWMODE_TRANSPARENT = $0004;

type
    TDESKBANDCID = (
        DBID_BANDINFOCHANGED = 0,
        DBID_SHOWONLY = 1,
        DBID_MAXIMIZEBAND = 2,
        DBID_PUSHCHEVRON = 3,
        DBID_DELAYINIT = 4,
        DBID_FINISHINIT = 5,
        DBID_SETWINDOWTHEME = 6,
        DBID_PERMITAUTOHIDE = 7
        );

const
    DBPC_SELECTFIRST = DWORD(-1);
    DBPC_SELECTLAST = DWORD(-2);


type
    IDeskBand = interface(IDockingWindow)
        ['{EB0FE172-1A3A-11D0-89B3-00A0C90A90AC}']
        function GetBandInfo(dwBandID: DWORD; dwViewMode: DWORD; var pdbi: TDESKBANDINFO): HResult; stdcall;
    end;




{$IF  (NTDDI_VERSION >= NTDDI_VISTA))}
    IDeskBandInfo = interface(IUnknown)
        ['{77E425FC-CBF9-4307-BA6A-BB5727745661}']
        function GetDefaultBandWidth(dwBandID: DWORD; dwViewMode: DWORD; out pnWidth: int32): HResult; stdcall;
    end;




    IDeskBand2 = interface(IDeskBand)
        ['{79D16DE4-ABEE-4021-8D9D-9169B261D657}']
        function CanRenderComposited(out pfCanRenderComposited: boolean): HResult; stdcall;
        function SetCompositionState(fCompositionEnabled: boolean): HResult; stdcall;
        function GetCompositionState(out pfCompositionEnabled: boolean): HResult; stdcall;
    end;


{$ENDIF}// NTDDI_VISTA



    ITaskbarList = interface(IUnknown)
        ['{56FDF342-FD6D-11d0-958A-006097C9A090}']
        function HrInit(): HResult; stdcall;
        function AddTab(hwnd: HWND): HResult; stdcall;
        function DeleteTab(hwnd: HWND): HResult; stdcall;
        function ActivateTab(hwnd: HWND): HResult; stdcall;
        function SetActiveAlt(hwnd: HWND): HResult; stdcall;
    end;


    ITaskbarList2 = interface(ITaskbarList)
        ['{602D4995-B13A-429b-A66E-1935E44F4317}']
        function MarkFullscreenWindow(hwnd: HWND; fFullscreen: boolean): HResult; stdcall;
    end;




type
    TTHUMBBUTTONFLAGS = (
        THBF_ENABLED = 0,
        THBF_DISABLED = $1,
        THBF_DISMISSONCLICK = $2,
        THBF_NOBACKGROUND = $4,
        THBF_HIDDEN = $8,
        THBF_NONINTERACTIVE = $10
        );


    TTHUMBBUTTONMASK = (
        THB_BITMAP = $1,
        THB_ICON = $2,
        THB_TOOLTIP = $4,
        THB_FLAGS = $8
        );


    //include <pshpack8.h>
{$A8}
    TTHUMBBUTTON = record
        dwMask: TTHUMBBUTTONMASK;
        iId: UINT;
        iBitmap: UINT;
        hIcon: HICON;
        szTip: array [0.. 259] of WCHAR;
        dwFlags: TTHUMBBUTTONFLAGS;
    end;
    PTHUMBBUTTON = ^TTHUMBBUTTON;

//include <poppack.h>
{$A4}
const
    THBN_CLICKED = $1800;




type

    TTBPFLAG = (
        TBPF_NOPROGRESS = 0,
        TBPF_INDETERMINATE = $1,
        TBPF_NORMAL = $2,
        TBPF_ERROR = $4,
        TBPF_PAUSED = $8
        );




    ITaskbarList3 = interface(ITaskbarList2)
        ['{ea1afb91-9e28-4b86-90e9-9e9f8a5eefaf}']
        function SetProgressValue(hwnd: HWND; ullCompleted: ULONGLONG; ullTotal: ULONGLONG): HResult; stdcall;
        function SetProgressState(hwnd: HWND; tbpFlags: TBPFLAG): HResult; stdcall;
        function RegisterTab(hwndTab: HWND; hwndMDI: HWND): HResult; stdcall;
        function UnregisterTab(hwndTab: HWND): HResult; stdcall;
        function SetTabOrder(hwndTab: HWND; hwndInsertBefore: HWND): HResult; stdcall;
        function SetTabActive(hwndTab: HWND; hwndMDI: HWND; dwReserved: DWORD): HResult; stdcall;
        function ThumbBarAddButtons(hwnd: HWND; cButtons: UINT; pButton: PTHUMBBUTTON): HResult; stdcall;
        function ThumbBarUpdateButtons(hwnd: HWND; cButtons: UINT; pButton: PTHUMBBUTTON): HResult; stdcall;
        function ThumbBarSetImageList(hwnd: HWND; himl: THIMAGELIST): HResult; stdcall;
        function SetOverlayIcon(hwnd: HWND; hIcon: HICON; pszDescription: LPCWSTR): HResult; stdcall;
        function SetThumbnailTooltip(hwnd: HWND; pszTip: LPCWSTR): HResult; stdcall;
        function SetThumbnailClip(hwnd: HWND; prcClip: PRECT): HResult; stdcall;
    end;



    TSTPFLAG = (
        STPF_NONE = 0,
        STPF_USEAPPTHUMBNAILALWAYS = $1,
        STPF_USEAPPTHUMBNAILWHENACTIVE = $2,
        STPF_USEAPPPEEKALWAYS = $4,
        STPF_USEAPPPEEKWHENACTIVE = $8
        );













































































































































































implementation

end.
