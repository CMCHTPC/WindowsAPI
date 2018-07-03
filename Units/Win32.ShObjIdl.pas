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
    Win32.ObjIdlBase, Win32.ComCat,
    Win32.ShObjIdl_Core, Win32.StructuredQueryCondition,
    Win32.OAIdl, Win32.ObjectArray,
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
    IID_ITaskbarList3: TGUID = '{ea1afb91-9e28-4b86-90e9-9e9f8a5eefaf}';
    IID_ITaskbarList4: TGUID = '{c43dc798-95d1-4bea-9030-bb99e2983a1a}';
    IID_IStartMenuPinnedList: TGUID = '{4CD19ADA-25A5-4A32-B3B7-347BEE5BE36B}';
    IID_ICDBurn: TGUID = '{3d73a659-e5d0-4d42-afc0-5121ba425c8d}';
    IID_IWizardExtension: TGUID = '{c02ea696-86cc-491e-9b23-74394a0444a8}';
    IID_IWebWizardExtension: TGUID = '{0e6b3f66-98d1-48c0-a222-fbde74e2fbc5}';
    IID_IPublishingWizard: TGUID = '{aa9198bb-ccec-472d-beed-19a4f6733f7a}';
    IID_IFolderViewHost: TGUID = '{1ea58f02-d55a-411d-b09e-9e65ac21605b}';
    IID_IExplorerBrowserEvents: TGUID = '{361bbdc7-e6ee-4e13-be58-58e2240c810f}';
    IID_IExplorerBrowser: TGUID = '{dfd3b6b5-c10c-4be9-85f6-a66969f402f6}';
    IID_IAccessibleObject: TGUID = '{95A391C5-9ED4-4c28-8401-AB9E06719E11}';
    IID_IResultsFolder: TGUID = '{96E5AE6D-6AE1-4b1c-900C-C6480EAA8828}';
    IID_IEnumObjects: TGUID = '{2c1c7e2e-2d0e-4059-831e-1e6f82335c2e}';
    IID_IOperationsProgressDialog: TGUID = '{0C9FB851-E5C9-43EB-A370-F0677B13874C}';
    IID_IIOCancelInformation: TGUID = '{f5b0bf81-8cb5-4b1b-9449-1a159e0c733c}';
    IID_IFileOperation: TGUID = '{947aab5f-0a5c-4c13-b4d6-4bf7836fc9f8}';
    IID_IObjectProvider: TGUID = '{a6087428-3be3-4d73-b308-7c04a540bf1a}';
    IID_INamespaceWalkCB: TGUID = '{d92995f8-cf5e-4a76-bf59-ead39ea2b97e}';
    IID_INamespaceWalkCB2: TGUID = '{7ac7492b-c38e-438a-87db-68737844ff70}';
    IID_INamespaceWalk: TGUID = '{57ced8a7-3f4a-432c-9350-30f24483f74f}';
    IID_IAutoCompleteDropDown: TGUID = '{3CD141F4-3C6A-11d2-BCAA-00C04FD929DB}';
    IID_IBandSite: TGUID = '{4CF504B0-DE96-11D0-8B3F-00A0C911E8E5}';
    IID_IModalWindow: TGUID = '{b4db1657-70d7-485e-8e3e-6fcb5a5c1802}';
    IID_ICDBurnExt: TGUID = '{2271dcca-74fc-4414-8fb7-c56b05ace2d7}';
    IID_IContextMenuSite: TGUID = '{0811AEBE-0B87-4C54-9E72-548CF649016B}';
    IID_IEnumReadyCallback: TGUID = '{61E00D45-8FFF-4e60-924E-6537B61612DD}';
    IID_IEnumerableView: TGUID = '{8C8BF236-1AEC-495f-9894-91D57C3C686F}';
    IID_IInsertItem: TGUID = '{D2B57227-3D23-4b95-93C0-492BD454C356}';
    IID_IMenuBand: TGUID = '{568804CD-CBD7-11d0-9816-00C04FD91972}';
    IID_IFolderBandPriv: TGUID = '{47c01f95-e185-412c-b5c5-4f27df965aea}';
    IID_IRegTreeItem: TGUID = '{A9521922-0812-4d44-9EC3-7FD38C726F3D}';
    IID_IImageRecompress: TGUID = '{505f1513-6b3e-4892-a272-59f8889a4d3e}';
    IID_IDeskBar: TGUID = '{EB0FE173-1A3A-11D0-89B3-00A0C90A90AC}';
    IID_IMenuPopup: TGUID = '{D1E7AFEB-6A2E-11d0-8C78-00C04FD918B4}';
    IID_IFileIsInUse: TGUID = '{64a1cbf0-3a1a-4461-9158-376969693950}';
    IID_IFileDialogEvents: TGUID = '{973510db-7d7f-452b-8975-74a85828d354}';
    IID_IFileDialog: TGUID = '{42f85136-db7e-439c-85f1-e4075d135fc8}';
    IID_IFileSaveDialog: TGUID = '{84bccd23-5fde-4cdb-aea4-af64b83d78ab}';
    IID_IFileOpenDialog: TGUID = '{d57c7288-d4ad-4768-be02-9d969532d960}';
    IID_IFileDialogCustomize: TGUID = '{e6fdd21a-163f-4975-9c8c-a69f1ba37034}';
    IID_IFileDialogControlEvents: TGUID = '{36116642-D713-4b97-9B83-7484A9D00433}';
    IID_IFileDialog2: TGUID = '{61744fc7-85b5-4791-a9b0-272276309b13}';
    IID_IApplicationAssociationRegistration: TGUID = '{4e530b0a-e611-4c77-a3ac-9031d022281b}';
    IID_IApplicationAssociationRegistrationUI: TGUID = '{1f76a169-f994-40ac-8fc8-0959e8874710}';
    IID_IDelegateFolder: TGUID = '{ADD8BA80-002B-11D0-8F0F-00C04FD7D062}';
    IID_IBrowserFrameOptions: TGUID = '{10DF43C8-1DBE-11d3-8B34-006097DF5BD4}';
    IID_INewWindowManager: TGUID = '{D2BC4C84-3F72-4a52-A604-7BCBF3982CBB}';
    IID_IAttachmentExecute: TGUID = '{73db1241-1e85-4581-8e4f-a81e1d0f8c57}';
    IID_IShellMenuCallback: TGUID = '{4CA300A1-9B8D-11d1-8B22-00C04FD918D0}';
    IID_IShellMenu: TGUID = '{EE1F7637-E138-11d1-8379-00C04FD918D0}';
    IID_IShellRunDll: TGUID = '{fce4bde0-4b68-4b80-8e9c-7426315a7388}';
    IID_IKnownFolder: TGUID = '{3AA7AF7E-9B36-420c-A8E3-F77D4674A488}';
    IID_IKnownFolderManager: TGUID = '{8BE2D872-86AA-4d47-B776-32CCA40C7018}';
    IID_ISharingConfigurationManager: TGUID = '{B4CD448A-9C86-4466-9201-2E62105B87AE}';
    IID_IPreviousVersionsInfo: TGUID = '{76e54780-ad74-48e3-a695-3ba9a0aff10d}';
    IID_IRelatedItem: TGUID = '{a73ce67a-8ab1-44f1-8d43-d2fcbf6b1cd0}';
    IID_IIdentityName: TGUID = '{7d903fca-d6f9-4810-8332-946c0177e247}';
    IID_IDelegateItem: TGUID = '{3c5a1c94-c951-4cb7-bb6d-3b93f30cce93}';
    IID_ICurrentItem: TGUID = '{240a7174-d653-4a1d-a6d3-d4943cfbfe3d}';
    IID_ITransferMediumItem: TGUID = '{77f295d5-2d6f-4e19-b8ae-322f3e721ab5}';
    IID_IUseToBrowseItem: TGUID = '{05edda5c-98a3-4717-8adb-c5e7da991eb1}';
    IID_IDisplayItem: TGUID = '{c6fd5997-9f6b-4888-8703-94e80e8cde3f}';
    IID_IViewStateIdentityItem: TGUID = '{9D264146-A94F-4195-9F9F-3BB12CE0C955}';
    IID_IPreviewItem: TGUID = '{36149969-0A8F-49c8-8B00-4AECB20222FB}';
    IID_IDestinationStreamFactory: TGUID = '{8a87781b-39a7-4a1f-aab3-a39b9c34a7d9}';
    IID_ICreateProcessInputs: TGUID = '{F6EF6140-E26F-4D82-bAC4-E9BA5FD239A8}';
    IID_ICreatingProcess: TGUID = '{c2b937a9-3110-4398-8a56-f34c6342d244}';
    IID_INewMenuClient: TGUID = '{dcb07fdc-3bb5-451c-90be-966644fed7b0}';
    IID_IInitializeWithBindCtx: TGUID = '{71c0d2bc-726d-45cc-a6c0-2e31c1db2159}';
    IID_IShellItemFilter: TGUID = '{2659B475-EEB8-48b7-8F07-B378810F48CF}';
    IID_INameSpaceTreeControl: TGUID = '{028212A3-B627-47e9-8856-C14265554E4F}';
    IID_INameSpaceTreeControl2: TGUID = '{7cc7aed8-290e-49bc-8945-c1401cc9306c}';
    IID_INameSpaceTreeControlEvents: TGUID = '{93D77985-B3D8-4484-8318-672CDDA002CE}';
    IID_INameSpaceTreeControlDropHandler: TGUID = '{F9C665D6-C2F2-4c19-BF33-8322D7352F51}';
    IID_INameSpaceTreeAccessible: TGUID = '{71f312de-43ed-4190-8477-e9536b82350b}';
    IID_INameSpaceTreeControlCustomDraw: TGUID = '{2D3BA758-33EE-42d5-BB7B-5F3431D86C78}';
    IID_INameSpaceTreeControlFolderCapabilities: TGUID = '{e9701183-e6b3-4ff2-8568-813615fec7be}';
    IID_IPreviewHandler: TGUID = '{8895b1c6-b41f-4c1c-a562-0d564250836f}';
    IID_IPreviewHandlerFrame: TGUID = '{fec87aaf-35f9-447a-adb7-20234491401a}';
    IID_ITrayDeskBand: TGUID = '{6D67E846-5B9C-4db8-9CBC-DDE12F4254F1}';
    IID_IBandHost: TGUID = '{B9075C7C-D48E-403f-AB99-D6C77A1084AC}';
    IID_IExplorerPaneVisibility: TGUID = '{e07010ec-bc17-44c0-97b0-46c7c95b9edc}';
    IID_IContextMenuCB: TGUID = '{3409E930-5A39-11d1-83FA-00A0C90DC849}';
    IID_IDefaultExtractIconInit: TGUID = '{41ded17d-d6b3-4261-997d-88c60e4b1d58}';
    IID_IExplorerCommand: TGUID = '{a08ce4d0-fa25-44ab-b57c-c7b1c323e0b9}';
    IID_IExplorerCommandState: TGUID = '{bddacb60-7657-47ae-8445-d23e1acf82ae}';
    IID_IInitializeCommand: TGUID = '{85075acf-231f-40ea-9610-d26b7b58f638}';
    IID_IEnumExplorerCommand: TGUID = '{a88826f8-186f-4987-aade-ea0cef8fbfe8}';
    IID_IExplorerCommandProvider: TGUID = '{64961751-0835-43c0-8ffe-d57686530e64}';
    IID_IInitializeNetworkFolder: TGUID = '{6e0f9881-42a8-4f2a-97f8-8af4e026d92d}';
    IID_IOpenControlPanel: TGUID = '{D11AD862-66DE-4DF4-BF6C-1F5621996AF1}';
    IID_IComputerInfoChangeNotify: TGUID = '{0DF60D92-6818-46d6-B358-D66170DDE466}';
    IID_IFileSystemBindData: TGUID = '{01E18D10-4D8B-11d2-855D-006008059367}';
    IID_IFileSystemBindData2: TGUID = '{3acf075f-71db-4afa-81f0-3fc4fdf2a5b8}';
    IID_ICustomDestinationList: TGUID = '{6332debf-87b5-4670-90c0-5e57b408a49e}';
    IID_IApplicationDestinations: TGUID = '{12337d35-94c6-48a0-bce7-6a9c69d4d600}';
    IID_IApplicationDocumentLists: TGUID = '{3c594f9f-9f30-47a1-979a-c9e83d3d0a06}';
    IID_IObjectWithAppUserModelID: TGUID = '{36db0196-9665-46d1-9ba7-d3709eecf9ed}';
    IID_IObjectWithProgID: TGUID = '{71e806fb-8dee-46fc-bf8c-7748a8a1ae13}';
    IID_IUpdateIDList: TGUID = '{6589b6d2-5f8d-4b9e-b7e0-23cdd9717d8c}';
    IID_IDesktopGadget: TGUID = '{c1646bc4-f298-4f91-a204-eb2dd1709d1a}';
    IID_IDesktopWallpaper: TGUID = '{B92B56A9-8B55-4E14-9A89-0199BBB6F93B}';
    IID_IHomeGroup: TGUID = '{7a3bd1d9-35a9-4fb3-a467-f48cac35e2d0}';
    IID_IInitializeWithPropertyStore: TGUID = '{C3E12EB5-7D8D-44f8-B6DD-0E77B34D6DE4}';
    IID_IOpenSearchSource: TGUID = '{F0EE7333-E6FC-479b-9F25-A860C234A38E}';
    IID_IShellLibrary: TGUID = '{11a66efa-382e-451a-9234-1e0e12ef3085}';
    IID_IDefaultFolderMenuInitialize: TGUID = '{7690aa79-f8fc-4615-a327-36f7d18f5d91}';
    IID_IApplicationActivationManager: TGUID = '{2e941141-7f97-4756-ba1d-9decde894a3d}';
    IID_IVirtualDesktopManager: TGUID = '{a5cd92ff-29be-454c-8d04-d82879fb3f1b}';
    IID_IAssocHandlerInvoker: TGUID = '{92218CAB-ECAA-4335-8133-807FD234C2EE}';
    IID_IAssocHandler: TGUID = '{F04061AC-1659-4a3f-A954-775AA57FC083}';
    IID_IEnumAssocHandlers: TGUID = '{973810ae-9599-4b88-9e4d-6ee98c9552da}';
    IID_IDataObjectProvider: TGUID = '{3D25F6D6-4B2A-433c-9184-7C33AD35D001}';
    IID_IDataTransferManagerInterop: TGUID = '{3A3DCD6C-3EAB-43DC-BCDE-45671CE800C8}';
    IID_IFrameworkInputPaneHandler: TGUID = '{226C537B-1E76-4D9E-A760-33DB29922F18}';
    IID_IFrameworkInputPane: TGUID = '{5752238B-24F0-495A-82F1-2FD593056796}';
    IID_IAccessibilityDockingServiceCallback: TGUID = '{157733FD-A592-42E5-B594-248468C5A81B}';
    IID_IAccessibilityDockingService: TGUID = '{8849DC22-CEDF-4C95-998D-051419DD3F76}';
    IID_IAppVisibilityEvents: TGUID = '{6584CE6B-7D82-49C2-89C9-C6BC02BA8C38}';
    IID_IAppVisibility: TGUID = '{2246EA2D-CAEA-4444-A3C4-6DE827E44313}';
    IID_IPackageDebugSettings: TGUID = '{F27C3930-8029-4AD1-94E3-3DBA417810C1}';
    IID_IPackageDebugSettings2: TGUID = '{6E3194BB-AB82-4D22-93F5-FABDA40E7B16}';
    IID_ISuspensionDependencyManager: TGUID = '{52B83A42-2543-416A-81D9-C0DE7969C8B3}';
    IID_IExecuteCommandApplicationHostEnvironment: TGUID = '{18B21AA9-E184-4FF0-9F5E-F882D03771B3}';
    IID_IExecuteCommandHost: TGUID = '{4b6832a2-5f04-4c9d-b89d-727a15d103e7}';
    IID_ILaunchTargetMonitor: TGUID = '{266FBC7E-490D-46ED-A96B-2274DB252003}';
    IID_ILaunchSourceViewSizePreference: TGUID = '{E5AA01F7-1FB8-4830-8720-4E6734CBD5F3}';

    SID_LaunchTargetMonitor: TGUID = '{8D547FA1-CC45-40C8-B7C1-D48C183F13F3}';
    SID_LaunchSourceViewSizePreference: TGUID = '{80605492-67d9-414f-af89-a1cdf1242bc1}';
    IID_ILaunchTargetViewSizePreference: TGUID = '{2F0666C6-12F7-4360-B511-A394A0553725}';

    SID_LaunchTargetViewSizePreference: TGUID = '{26db2472-b7b7-406b-9702-730a4e20d3bf}';
    IID_ILaunchSourceAppUserModelId: TGUID = '{989191AC-28FF-4CF0-9584-E0D078BC2396}';


    SID_URLExecutionContext: TGUID = '{FB5F8EBC-BBB6-4D10-A461-777291A09030}';
    SID_LaunchSourceAppUserModelId: TGUID = '{2ce78010-74db-48bc-9c6a-10f372495723}';
    IID_IHandlerInfo: TGUID = '{997706ef-f880-453b-8118-39e1a2d2655a}';
    IID_IHandlerActivationHost: TGUID = '{35094a87-8bb1-4237-96c6-c417eebdb078}';
    IID_IAppActivationUIInfo: TGUID = '{abad189d-9fa3-4278-b3ca-8ca448a88dcb}';
    SID_ShellExecuteNamedPropertyStore: TGUID = '{eb84ada2-00ff-4992-8324-ed5ce061cb29}';
    IID_IContactManagerInterop: TGUID = '{99eacba7-e073-43b6-a896-55afe48a0833}';

    SID_SCommandBarState: TGUID = '{B99EAA5C-3850-4400-BC33-2CE534048BF8}';

const
    CLSID_DesktopWallpaper: TGUID = '{C2CF3110-460E-4fc1-B9D0-8A1C0C9CC4BD}';
    CLSID_ShellDesktop: TGUID = '{00021400-0000-0000-C000-000000000046}';
    CLSID_ShellFSFolder: TGUID = '{F3364BA0-65B9-11CE-A9BA-00AA004AE837}';
    CLSID_NetworkPlaces: TGUID = '{208D2C60-3AEA-1069-A2D7-08002B30309D}';
    CLSID_ShellLink: TGUID = '{00021401-0000-0000-C000-000000000046}';
    CLSID_QueryCancelAutoPlay: TGUID = '{331F1768-05A9-4ddd-B86E-DAE34DDC998A}';
    CLSID_DriveSizeCategorizer: TGUID = '{94357B53-CA29-4b78-83AE-E8FE7409134F}';
    CLSID_DriveTypeCategorizer: TGUID = '{B0A8F3CF-4333-4bab-8873-1CCB1CADA48B}';
    CLSID_FreeSpaceCategorizer: TGUID = '{B5607793-24AC-44c7-82E2-831726AA6CB7}';
    CLSID_TimeCategorizer: TGUID = '{3bb4118f-ddfd-4d30-a348-9fb5d6bf1afe}';
    CLSID_SizeCategorizer: TGUID = '{55d7b852-f6d1-42f2-aa75-8728a1b2d264}';
    CLSID_AlphabeticalCategorizer: TGUID = '{3c2654c6-7372-4f6b-b310-55d6128f49d2}';
    CLSID_MergedCategorizer: TGUID = '{8e827c11-33e7-4bc1-b242-8cd9a1c2b304}';
    CLSID_ImageProperties: TGUID = '{7ab770c7-0e23-4d7a-8aa2-19bfad479829}';
    CLSID_PropertiesUI: TGUID = '{d912f8cf-0396-4915-884e-fb425d32943b}';
    CLSID_UserNotification: TGUID = '{0010890e-8789-413c-adbc-48f5b511b3af}';
    CLSID_CDBurn: TGUID = '{fbeb8a05-beee-4442-804e-409d6c4515e9}';
    CLSID_TaskbarList: TGUID = '{56FDF344-FD6D-11d0-958A-006097C9A090}';
    CLSID_StartMenuPin: TGUID = '{a2a9545d-a0c2-42b4-9708-a0b2badd77c8}';
    CLSID_WebWizardHost: TGUID = '{c827f149-55c1-4d28-935e-57e47caed973}';
    CLSID_PublishDropTarget: TGUID = '{CC6EEFFB-43F6-46c5-9619-51D571967F7D}';
    CLSID_PublishingWizard: TGUID = '{6b33163c-76a5-4b6c-bf21-45de9cd503a1}';
    CLSID_InternetPrintOrdering: TGUID = '{add36aa8-751a-4579-a266-d66f5202ccbb}';
    CLSID_FolderViewHost: TGUID = '{20b1cb23-6968-4eb9-b7d4-a66d00d07cee}';
    CLSID_ExplorerBrowser: TGUID = '{71f96385-ddd6-48d3-a0c1-ae06e8b055fb}';
    CLSID_ImageRecompress: TGUID = '{6e33091c-d2f8-4740-b55e-2e11d1477a2c}';
    CLSID_TrayBandSiteService: TGUID = '{F60AD0A0-E5E1-45cb-B51A-E15B9F8B2934}';
    CLSID_TrayDeskBand: TGUID = '{E6442437-6C68-4f52-94DD-2CFED267EFB9}';
    CLSID_AttachmentServices: TGUID = '{4125dd96-e03a-4103-8f70-e0597d803b9c}';
    CLSID_DocPropShellExtension: TGUID = '{883373C3-BF89-11D1-BE35-080036B11A03}';
    CLSID_NamespaceWalker: TGUID = '{72eb61e0-8672-4303-9175-f2e4c68b2e7c}';
    CLSID_FileOperation: TGUID = '{3ad05575-8857-4850-9277-11b85bdb8e09}';
    CLSID_FileOpenDialog: TGUID = '{DC1C5A9C-E88A-4dde-A5A1-60F82A20AEF7}';
    CLSID_FileSaveDialog: TGUID = '{C0B4E2F3-BA21-4773-8DBA-335EC946EB8B}';
    CLSID_KnownFolderManager: TGUID = '{4df0c730-df9d-4ae3-9153-aa6b82e9795a}';
    CLSID_FSCopyHandler: TGUID = '{D197380A-0A79-4dc8-A033-ED882C2FA14B}';
    CLSID_SharingConfigurationManager: TGUID = '{49F371E1-8C5C-4d9c-9A3B-54A6827F513C}';
    CLSID_PreviousVersions: TGUID = '{596AB062-B4D2-4215-9F74-E9109B0A8153}';
    CLSID_NetworkConnections: TGUID = '{7007ACC7-3202-11D1-AAD2-00805FC1270E}';
    CLSID_NamespaceTreeControl: TGUID = '{AE054212-3535-4430-83ED-D501AA6680E6}';
    CLSID_IENamespaceTreeControl: TGUID = '{ACE52D03-E5CD-4b20-82FF-E71B11BEAE1D}';
    CLSID_ScheduledTasks: TGUID = '{D6277990-4C6A-11CF-8D87-00AA0060F5BF}';
    CLSID_ApplicationAssociationRegistration: TGUID = '{591209c7-767b-42b2-9fba-44ee4615f2c7}';
    CLSID_ApplicationAssociationRegistrationUI: TGUID = '{1968106d-f3b5-44cf-890e-116fcb9ecef1}';
    CLSID_SearchFolderItemFactory: TGUID = '{14010e02-bbbd-41f0-88e3-eda371216584}';
    CLSID_OpenControlPanel: TGUID = '{06622D85-6856-4460-8DE1-A81921B41C4B}';
    CLSID_MailRecipient: TGUID = '{9E56BE60-C50F-11CF-9A2C-00A0C90A90CE}';
    CLSID_NetworkExplorerFolder: TGUID = '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}';
    CLSID_DestinationList: TGUID = '{77f10cf0-3db5-4966-b520-b7c54fd35ed6}';
    CLSID_ApplicationDestinations: TGUID = '{86c14003-4d6b-4ef3-a7b4-0506663b2e68}';
    CLSID_ApplicationDocumentLists: TGUID = '{86bec222-30f2-47e0-9f25-60d11cd75c28}';
    CLSID_HomeGroup: TGUID = '{DE77BA04-3C92-4d11-A1A5-42352A53E0E3}';
    CLSID_ShellLibrary: TGUID = '{d9b3211d-e57f-4426-aaef-30a806add397}';
    CLSID_AppStartupLink: TGUID = '{273eb5e7-88b0-4843-bfef-e2c81d43aae5}';
    CLSID_EnumerableObjectCollection: TGUID = '{2d3468c1-36a7-43b6-ac24-d3f02fd9607a}';
    CLSID_DesktopGadget: TGUID = '{924ccc1b-6562-4c85-8657-d177925222b6}';
    CLSID_AccessibilityDockingService: TGUID = '{29CE1D46-B481-4AA0-A08A-D3EBC8ACA402}';
    CLSID_FrameworkInputPane: TGUID = '{D5120AA3-46BA-44C5-822D-CA8092C1FC72}';
    CLSID_DefFolderMenu: TGUID = '{c63382be-7933-48d0-9ac8-85fb46be2fdd}';
    CLSID_AppVisibility: TGUID = '{7E5FE3D9-985F-4908-91F9-EE19F9FD1514}';
    CLSID_AppShellVerbHandler: TGUID = '{4ED3A719-CEA8-4BD9-910D-E252F997AFC2}';
    CLSID_ExecuteUnknown: TGUID = '{e44e9428-bdbc-4987-a099-40dc8fd255e7}';
    CLSID_PackageDebugSettings: TGUID = '{B1AEC16F-2383-4852-B0E9-8F0B1DC66B4D}';
    CLSID_SuspensionDependencyManager: TGUID = '{6B273FC5-61FD-4918-95A2-C3B5E9D7F581}';
    CLSID_ApplicationActivationManager: TGUID = '{45BA127D-10A8-46EA-8AB7-56EA9078943C}';
    CLSID_ExecuteFolder: TGUID = '{11dbb47c-a525-400b-9e80-a54615a090c0}';
    CLSID_VirtualDesktopManager: TGUID = '{aa509086-5ca9-4c25-8f95-589d3c07b48a}';

{const
    SID_ShellTaskScheduler = IID_IShellTaskScheduler;   }

const
    DI_GETDRAGIMAGE  : ansistring =   'ShellGetDragImage';


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
    PFNSVADDPROPSHEETPAGE = LPARAM;


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
        function AddPropertySheetPages(dwReserved: DWORD; pfn: PFNSVADDPROPSHEETPAGE; lparam: LPARAM): HResult; stdcall;
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
    PSHELL_ITEM_RESOURCE = ^TSHELL_ITEM_RESOURCE;



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


    TPROPID = ULONG;

    IPropertyUI = interface(IUnknown)
        ['{757a7d9f-919a-4118-99d7-dbb208c8cc66}']
        function ParsePropertyName(pszName: LPCWSTR; out pfmtid: TFMTID; out ppid: TPROPID; var pchEaten: ULONG): HResult; stdcall;
        function GetCannonicalName(const fmtid: TFMTID; pid: TPROPID; pwszText: LPWSTR; cchText: DWORD): HResult; stdcall;
        function GetDisplayName(const fmtid: TFMTID; pid: TPROPID; flags: TPROPERTYUI_NAME_FLAGS; pwszText: LPWSTR;
            cchText: DWORD): HResult; stdcall;
        function GetPropertyDescription(const fmtid: TFMTID; pid: TPROPID; out pwszText: LPWSTR; cchText: DWORD): HResult; stdcall;
        function GetDefaultWidth(const fmtid: TFMTID; pid: TPROPID; out pcxChars: ULONG): HResult; stdcall;
        function GetFlags(const fmtid: TFMTID; pid: TPROPID; out pflags: TPROPERTYUI_FLAGS): HResult; stdcall;
        function FormatForDisplay(const fmtid: TFMTID; pid: TPROPID; const ppropvar: TPROPVARIANT; puiff: TPROPERTYUI_FORMAT_FLAGS;
            out pwszText: LPWSTR; cchText: DWORD): HResult; stdcall;
        function GetHelpInfo(const fmtid: TFMTID; pid: TPROPID; out pwszHelpFile: LPWSTR; cch: DWORD; out puHelpID: UINT): HResult; stdcall;
    end;




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
        function ResizeBorderDW(prcBorder: PRECT; punkToolbarSite: IUnknown; fReserved: boolean): HResult; stdcall;
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
        function SetProgressState(hwnd: HWND; tbpFlags: TTBPFLAG): HResult; stdcall;
        function RegisterTab(hwndTab: HWND; hwndMDI: HWND): HResult; stdcall;
        function UnregisterTab(hwndTab: HWND): HResult; stdcall;
        function SetTabOrder(hwndTab: HWND; hwndInsertBefore: HWND): HResult; stdcall;
        function SetTabActive(hwndTab: HWND; hwndMDI: HWND; dwReserved: DWORD): HResult; stdcall;
        function ThumbBarAddButtons(hwnd: HWND; cButtons: UINT; pButton: PTHUMBBUTTON): HResult; stdcall;
        function ThumbBarUpdateButtons(hwnd: HWND; cButtons: UINT; pButton: PTHUMBBUTTON): HResult; stdcall;
        function ThumbBarSetImageList(hwnd: HWND; himl: HIMAGELIST): HResult; stdcall;
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




    ITaskbarList4 = interface(ITaskbarList3)
        ['{c43dc798-95d1-4bea-9030-bb99e2983a1a}']
        function SetTabProperties(hwndTab: HWND; stpFlags: TSTPFLAG): HResult; stdcall;

    end;

    IStartMenuPinnedList = interface(IUnknown)
        ['{4CD19ADA-25A5-4A32-B3B7-347BEE5BE36B}']
        function RemoveFromList(pitem: IShellItem): HResult; stdcall;
    end;



    ICDBurn = interface(IUnknown)
        ['{3d73a659-e5d0-4d42-afc0-5121ba425c8d}']
        function GetRecorderDriveLetter(out pszDrive: LPWSTR; cch: UINT): HResult; stdcall;
        function Burn(hwnd: HWND): HResult; stdcall;
        function HasRecordableDrive(out pfHasRecorder: boolean): HResult; stdcall;
    end;



const
    IDD_WIZEXTN_FIRST = $5000;
    IDD_WIZEXTN_LAST = $5100;




type
    IWizardSite = interface(IUnknown)
        ['{88960f5b-422f-4e7b-8013-73415381c3c3}']
        function GetPreviousPage(out phpage: HPROPSHEETPAGE): HResult; stdcall;
        function GetNextPage(out phpage: HPROPSHEETPAGE): HResult; stdcall;
        function GetCancelledPage(out phpage: HPROPSHEETPAGE): HResult; stdcall;
    end;

    IWizardExtension = interface(IUnknown)
        ['{c02ea696-86cc-491e-9b23-74394a0444a8}']
        function AddPages(out aPages: HPROPSHEETPAGE; cPages: UINT; out pnPagesAdded: UINT): HResult; stdcall;
        function GetFirstPage(out phpage: HPROPSHEETPAGE): HResult; stdcall;
        function GetLastPage(out phpage: HPROPSHEETPAGE): HResult; stdcall;
    end;




    IWebWizardExtension = interface(IWizardExtension)
        ['{0e6b3f66-98d1-48c0-a222-fbde74e2fbc5}']
        function SetInitialURL(pszURL: LPCWSTR): HResult; stdcall;
        function SetErrorURL(pszErrorURL: LPCWSTR): HResult; stdcall;
    end;



const
    SHPWHF_NORECOMPRESS = $00000001;  // don't allow/prompt for recompress of streams
    SHPWHF_NONETPLACECREATE = $00000002;  // don't create a network place when transfer is complete
    SHPWHF_NOFILESELECTOR = $00000004; // don't show the file selector
    SHPWHF_USEMRU = $00000008; // For OPW.  Use the Most-Recently-Used Print Provider
{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    SHPWHF_ANYLOCATION = $00000100;  // allow publishing to any location
{$ENDIF}// NTDDI_VISTA
    SHPWHF_VALIDATEVIAWEBFOLDERS = $00010000;  // enable web folders to validate network places (ANP support)




type
    IXMLDOMDocument = pointer; // ToDo

    IPublishingWizard = interface(IWizardExtension)
        ['{aa9198bb-ccec-472d-beed-19a4f6733f7a}']
        function Initialize(pdo: IDataObject; dwOptions: DWORD; pszServiceScope: LPCWSTR): HResult; stdcall;
        function GetTransferManifest(out phrFromTransfer: HRESULT; out pdocManifest: IXMLDOMDocument): HResult; stdcall;
    end;




{$IF  (NTDDI_VERSION >= NTDDI_WINXP)  OR  (_WIN32_IE >= _WIN32_IE_IE70)}
    IFolderViewHost = interface(IUnknown)
        ['{1ea58f02-d55a-411d-b09e-9e65ac21605b}']
        function Initialize(hwndParent: HWND; pdo: IDataObject; prc: PRECT): HResult; stdcall;
    end;


{$IF  (_WIN32_IE >= _WIN32_IE_IE70)}
    IExplorerBrowserEvents = interface(IUnknown)
        ['{361bbdc7-e6ee-4e13-be58-58e2240c810f}']
        function OnNavigationPending(pidlFolder: PCIDLIST_ABSOLUTE): HResult; stdcall;
        function OnViewCreated(psv: IShellView): HResult; stdcall;
        function OnNavigationComplete(pidlFolder: PCIDLIST_ABSOLUTE): HResult; stdcall;
        function OnNavigationFailed(pidlFolder: PCIDLIST_ABSOLUTE): HResult; stdcall;
    end;


    TEXPLORER_BROWSER_OPTIONS = (
        EBO_NONE = 0,
        EBO_NAVIGATEONCE = $1,
        EBO_SHOWFRAMES = $2,
        EBO_ALWAYSNAVIGATE = $4,
        EBO_NOTRAVELLOG = $8,
        EBO_NOWRAPPERWINDOW = $10,
        EBO_HTMLSHAREPOINTVIEW = $20,
        EBO_NOBORDER = $40,
        EBO_NOPERSISTVIEWSTATE = $80
        );


    TEXPLORER_BROWSER_FILL_FLAGS = (
        EBF_NONE = 0,
        EBF_SELECTFROMDATAOBJECT = $100,
        EBF_NODROPTARGET = $200
        );



    IExplorerBrowser = interface(IUnknown)
        ['{dfd3b6b5-c10c-4be9-85f6-a66969f402f6}']
        function Initialize(hwndParent: HWND; const prc: TRECT; const pfs: TFOLDERSETTINGS): HResult; stdcall;
        function Destroy(): HResult; stdcall;
        function SetRect(var phdwp: HDWP; rcBrowser: TRECT): HResult; stdcall;
        function SetPropertyBag(pszPropertyBag: LPCWSTR): HResult; stdcall;
        function SetEmptyText(pszEmptyText: LPCWSTR): HResult; stdcall;
        function SetFolderSettings(const pfs: TFOLDERSETTINGS): HResult; stdcall;
        function Advise(psbe: IExplorerBrowserEvents; out pdwCookie: DWORD): HResult; stdcall;
        function Unadvise(dwCookie: DWORD): HResult; stdcall;
        function SetOptions(dwFlag: TEXPLORER_BROWSER_OPTIONS): HResult; stdcall;
        function GetOptions(out pdwFlag: TEXPLORER_BROWSER_OPTIONS): HResult; stdcall;
        function BrowseToIDList(pidl: PCUIDLIST_RELATIVE; uFlags: UINT): HResult; stdcall;
        function BrowseToObject(punk: IUnknown; uFlags: UINT): HResult; stdcall;
        function FillFromObject(punk: IUnknown; dwFlags: TEXPLORER_BROWSER_FILL_FLAGS): HResult; stdcall;
        function RemoveAll(): HResult; stdcall;
        function GetCurrentView(const riid: TGUID; out ppv): HResult; stdcall;
    end;


    IAccessibleObject = interface(IUnknown)
        ['{95A391C5-9ED4-4c28-8401-AB9E06719E11}']
        function SetAccessibleName(pszName: LPCWSTR): HResult; stdcall;
    end;


{$ENDIF}// (_WIN32_IE >= _WIN32_IE_IE70)


    IResultsFolder = interface(IUnknown)
        ['{96E5AE6D-6AE1-4b1c-900C-C6480EAA8828}']
        function AddItem(psi: IShellItem): HResult; stdcall;
        function AddIDList(pidl: PCIDLIST_ABSOLUTE; out ppidlAdded: PITEMID_CHILD): HResult; stdcall;
        function RemoveItem(psi: IShellItem): HResult; stdcall;
        function RemoveIDList(pidl: PCIDLIST_ABSOLUTE): HResult; stdcall;
        function RemoveAll(): HResult; stdcall;
    end;


{$IF  (_WIN32_IE >= _WIN32_IE_IE70)}
    IEnumObjects = interface(IUnknown)
        ['{2c1c7e2e-2d0e-4059-831e-1e6f82335c2e}']
        function Next(celt: ULONG; const riid: TGUID; out rgelt: pointer; out pceltFetched: ULONG): HResult; stdcall;
        function Skip(celt: ULONG): HResult; stdcall;
        function Reset(): HResult; stdcall;
        function Clone(out ppenum: IEnumObjects): HResult; stdcall;
    end;


    TOPPROGDLGF = (
        OPPROGDLG_DEFAULT = DWORD(0),
        OPPROGDLG_ENABLEPAUSE = $80,
        OPPROGDLG_ALLOWUNDO = $100,
        OPPROGDLG_DONTDISPLAYSOURCEPATH = $200,
        OPPROGDLG_DONTDISPLAYDESTPATH = $400,
        OPPROGDLG_NOMULTIDAYESTIMATES = $800,
        OPPROGDLG_DONTDISPLAYLOCATIONS = $1000
        );


    TPDMODE = (
        PDM_DEFAULT = DWORD(0),
        PDM_RUN = $1,
        PDM_PREFLIGHT = $2,
        PDM_UNDOING = $4,
        PDM_ERRORSBLOCKING = $8,
        PDM_INDETERMINATE = $10
        );

    TPDOPSTATUS = (
        PDOPS_RUNNING = 1,
        PDOPS_PAUSED = 2,
        PDOPS_CANCELLED = 3,
        PDOPS_STOPPED = 4,
        PDOPS_ERRORS = 5
        );

    IOperationsProgressDialog = interface(IUnknown)
        ['{0C9FB851-E5C9-43EB-A370-F0677B13874C}']
        function StartProgressDialog(hwndOwner: HWND; flags: TOPPROGDLGF): HResult; stdcall;
        function StopProgressDialog(): HResult; stdcall;
        function SetOperation(action: TSPACTION): HResult; stdcall;
        function SetMode(mode: TPDMODE): HResult; stdcall;
        function UpdateProgress(ullPointsCurrent: ULONGLONG; ullPointsTotal: ULONGLONG; ullSizeCurrent: ULONGLONG;
            ullSizeTotal: ULONGLONG; ullItemsCurrent: ULONGLONG; ullItemsTotal: ULONGLONG): HResult; stdcall;
        function UpdateLocations(psiSource: IShellItem; psiTarget: IShellItem; psiItem: IShellItem): HResult; stdcall;
        function ResetTimer(): HResult; stdcall;
        function PauseTimer(): HResult; stdcall;
        function ResumeTimer(): HResult; stdcall;
        function GetMilliseconds(out pullElapsed: ULONGLONG; out pullRemaining: ULONGLONG): HResult; stdcall;
        function GetOperationStatus(out popstatus: TPDOPSTATUS): HResult; stdcall;
    end;


    IIOCancelInformation = interface(IUnknown)
        ['{f5b0bf81-8cb5-4b1b-9449-1a159e0c733c}']
        function SetCancelInformation(dwThreadID: DWORD; uMsgCancel: UINT): HResult; stdcall;
        function GetCancelInformation(out pdwThreadID: DWORD; out puMsgCancel: UINT): HResult; stdcall;
    end;

const
    FOFX_NOSKIPJUNCTIONS = $00010000;  // Don't avoid binding to junctions (like Task folder, Recycle-Bin)
    FOFX_PREFERHARDLINK = $00020000;  // Create hard link if possible
    FOFX_SHOWELEVATIONPROMPT = $00040000;  // Show elevation prompts when error UI is disabled (use with FOF_NOERRORUI)
    FOFX_RECYCLEONDELETE = $00080000;  // Recycle when deleting, rather than permanently deleting
    FOFX_EARLYFAILURE = $00100000;
    // Fail operation as soon as a single error occurs rather than trying to process other items (applies only when using FOF_NOERRORUI)
    FOFX_PRESERVEFILEEXTENSIONS = $00200000;  // Rename collisions preserve file extns (use with FOF_RENAMEONCOLLISION)
    FOFX_KEEPNEWERFILE = $00400000;  // Keep newer file on naming conflicts
    FOFX_NOCOPYHOOKS = $00800000;  // Don't use copy hooks
    FOFX_NOMINIMIZEBOX = $01000000;  // Don't allow minimizing the progress dialog
    FOFX_MOVEACLSACROSSVOLUMES = $02000000;  // Copy security information when performing a cross-volume move operation
    FOFX_DONTDISPLAYSOURCEPATH = $04000000;  // Don't display the path of source file in progress dialog
    FOFX_DONTDISPLAYDESTPATH = $08000000;  // Don't display the path of destination file in progress dialog
    FOFX_REQUIREELEVATION = $10000000;  // User expects the elevation; don't show a dialog to confirm
    FOFX_ADDUNDORECORD = $20000000;
    // This is a user-invoked operation, and should be placed on the undo stack.  This flag is preferred to FOF_ALLOWUNDO
    FOFX_COPYASDOWNLOAD = $40000000;  // Show Downloading instead of Copying
    FOFX_DONTDISPLAYLOCATIONS = $80000000;  // Hides the locations line in the progress dialog


type
    IFileOperation = interface(IUnknown)
        ['{947aab5f-0a5c-4c13-b4d6-4bf7836fc9f8}']
        function Advise(pfops: IFileOperationProgressSink; out pdwCookie: DWORD): HResult; stdcall;
        function Unadvise(dwCookie: DWORD): HResult; stdcall;
        function SetOperationFlags(dwOperationFlags: DWORD): HResult; stdcall;
        function SetProgressMessage(pszMessage: LPCWSTR): HResult; stdcall;
        function SetProgressDialog(popd: IOperationsProgressDialog): HResult; stdcall;
        function SetProperties(pproparray: IPropertyChangeArray): HResult; stdcall;
        function SetOwnerWindow(hwndOwner: HWND): HResult; stdcall;
        function ApplyPropertiesToItem(psiItem: IShellItem): HResult; stdcall;
        function ApplyPropertiesToItems(punkItems: IUnknown): HResult; stdcall;
        function RenameItem(psiItem: IShellItem; pszNewName: LPCWSTR; pfopsItem: IFileOperationProgressSink): HResult; stdcall;
        function RenameItems(pUnkItems: IUnknown; pszNewName: LPCWSTR): HResult; stdcall;
        function MoveItem(psiItem: IShellItem; psiDestinationFolder: IShellItem; pszNewName: LPCWSTR;
            pfopsItem: IFileOperationProgressSink): HResult; stdcall;
        function MoveItems(punkItems: IUnknown; psiDestinationFolder: IShellItem): HResult; stdcall;
        function CopyItem(psiItem: IShellItem; psiDestinationFolder: IShellItem; pszCopyName: LPCWSTR;
            pfopsItem: IFileOperationProgressSink): HResult; stdcall;
        function CopyItems(punkItems: IUnknown; psiDestinationFolder: IShellItem): HResult; stdcall;
        function DeleteItem(psiItem: IShellItem; pfopsItem: IFileOperationProgressSink): HResult; stdcall;
        function DeleteItems(punkItems: IUnknown): HResult; stdcall;
        function NewItem(psiDestinationFolder: IShellItem; dwFileAttributes: DWORD; pszName: LPCWSTR;
            pszTemplateName: LPCWSTR; pfopsItem: IFileOperationProgressSink): HResult; stdcall;
        function PerformOperations(): HResult; stdcall;
        function GetAnyOperationsAborted(out pfAnyOperationsAborted: boolean): HResult; stdcall;
    end;


    IObjectProvider = interface(IUnknown)
        ['{a6087428-3be3-4d73-b308-7c04a540bf1a}']
        function QueryObject(const guidObject: TGUID; const riid: TGUID; out ppvOut): HResult; stdcall;
    end;

{$ENDIF}// (_WIN32_IE >= _WIN32_IE_IE70)


    INamespaceWalkCB = interface(IUnknown)
        ['{d92995f8-cf5e-4a76-bf59-ead39ea2b97e}']
        function FoundItem(psf: IShellFolder; pidl: PCUITEMID_CHILD): HResult; stdcall;
        function EnterFolder(psf: IShellFolder; pidl: PCUITEMID_CHILD): HResult; stdcall;
        function LeaveFolder(psf: IShellFolder; pidl: PCUITEMID_CHILD): HResult; stdcall;
        function InitializeProgressDialog(out ppszTitle: LPWSTR; out ppszCancel: LPWSTR): HResult; stdcall;
    end;


{$IF  (_WIN32_IE >= _WIN32_IE_IE70)}

    INamespaceWalkCB2 = interface(INamespaceWalkCB)
        ['{7ac7492b-c38e-438a-87db-68737844ff70}']
        function WalkComplete(hr: HRESULT): HResult; stdcall;
    end;

{$ENDIF}// (_WIN32_IE >= _WIN32_IE_IE70)


    TNAMESPACEWALKFLAG = (
        NSWF_DEFAULT = 0,
        NSWF_NONE_IMPLIES_ALL = $1,
        NSWF_ONE_IMPLIES_ALL = $2,
        NSWF_DONT_TRAVERSE_LINKS = $4,
        NSWF_DONT_ACCUMULATE_RESULT = $8,
        NSWF_TRAVERSE_STREAM_JUNCTIONS = $10,
        NSWF_FILESYSTEM_ONLY = $20,
        NSWF_SHOW_PROGRESS = $40,
        NSWF_FLAG_VIEWORDER = $80,
        NSWF_IGNORE_AUTOPLAY_HIDA = $100,
        NSWF_ASYNC = $200,
        NSWF_DONT_RESOLVE_LINKS = $400,
        NSWF_ACCUMULATE_FOLDERS = $800,
        NSWF_DONT_SORT = $1000,
        NSWF_USE_TRANSFER_MEDIUM = $2000,
        NSWF_DONT_TRAVERSE_STREAM_JUNCTIONS = $4000,
        NSWF_ANY_IMPLIES_ALL = $8000
        );


    INamespaceWalk = interface(IUnknown)
        ['{57ced8a7-3f4a-432c-9350-30f24483f74f}']
        function Walk(punkToWalk: IUnknown; dwFlags: DWORD; cDepth: int32; pnswcb: INamespaceWalkCB): HResult; stdcall;
        function GetIDArrayResult(out pcItems: UINT; out prgpidl: PIDLIST_ABSOLUTE): HResult; stdcall;
    end;

{$ENDIF}// NTDDI_WINXP  OR  (_WIN32_IE >= _WIN32_IE_IE70)

const
    ACDD_VISIBLE = $0001;




type
    IAutoCompleteDropDown = interface(IUnknown)
        ['{3CD141F4-3C6A-11d2-BCAA-00C04FD929DB}']
        function GetDropDownStatus(out pdwFlags: DWORD; out ppwszString: LPWSTR): HResult; stdcall;
        function ResetEnumerator(): HResult; stdcall;
    end;


    //include <pshpack8.h>
{$A8}
    TBANDSITEINFO = record
        dwMask: DWORD;
        dwState: DWORD;
        dwStyle: DWORD;
    end;

    //include <poppack.h>
{$A4}

    TBANDSITECID = (
        BSID_BANDADDED = 0,
        BSID_BANDREMOVED = (BSID_BANDADDED + 1)
        );

const
    BSIM_STATE = $00000001;
    BSIM_STYLE = $00000002;
    BSSF_VISIBLE = $00000001;
    BSSF_NOTITLE = $00000002;
    BSSF_UNDELETEABLE = $00001000;
    BSIS_AUTOGRIPPER = $00000000;
    BSIS_NOGRIPPER = $00000001;
    BSIS_ALWAYSGRIPPER = $00000002;
    BSIS_LEFTALIGN = $00000004;
    BSIS_SINGLECLICK = $00000008;
    BSIS_NOCONTEXTMENU = $00000010;
    BSIS_NODROPTARGET = $00000020;
    BSIS_NOCAPTION = $00000040;
    BSIS_PREFERNOLINEBREAK = $00000080;
    BSIS_LOCKED = $00000100;
{$IF  (_WIN32_IE >= _WIN32_IE_IE70)}
    BSIS_PRESERVEORDERDURINGLAYOUT = $00000200;
    BSIS_FIXEDORDER = $00000400;
{$ENDIF}// _WIN32_IE_IE70



type
    IBandSite = interface(IUnknown)
        ['{4CF504B0-DE96-11D0-8B3F-00A0C911E8E5}']
        function AddBand(punk: IUnknown): HResult; stdcall;
        function EnumBands(uBand: UINT; out pdwBandID: DWORD): HResult; stdcall;
        function QueryBand(dwBandID: DWORD; out ppstb: IDeskBand; out pdwState: DWORD; out pszName: LPWSTR;
            cchName: int32): HResult; stdcall;
        function SetBandState(dwBandID: DWORD; dwMask: DWORD; dwState: DWORD): HResult; stdcall;
        function RemoveBand(dwBandID: DWORD): HResult; stdcall;
        function GetBandObject(dwBandID: DWORD; const riid: TGUID; out ppv): HResult; stdcall;
        function SetBandSiteInfo(const pbsinfo: TBANDSITEINFO): HResult; stdcall;
        function GetBandSiteInfo(var pbsinfo: TBANDSITEINFO): HResult; stdcall;
    end;


{$IF  (NTDDI_VERSION >= NTDDI_WINXP)}

    IModalWindow = interface(IUnknown)
        ['{b4db1657-70d7-485e-8e3e-6fcb5a5c1802}']
        function Show(hwndOwner: HWND): HResult; stdcall;
    end;


const
    PROPSTR_EXTENSIONCOMPLETIONSTATE: WideString = 'ExtensionCompletionState';

type
    TCDBURNINGEXTENSIONRET = (
        CDBE_RET_DEFAULT = 0,
        CDBE_RET_DONTRUNOTHEREXTS = $1,
        CDBE_RET_STOPWIZARD = $2
        );

    TCDBE_ACTIONS = (
        CDBE_TYPE_MUSIC = DWORD($1),
        CDBE_TYPE_DATA = $2,
        CDBE_TYPE_ALL = int32($ffffffff)
        );

    ICDBurnExt = interface(IUnknown)
        ['{2271dcca-74fc-4414-8fb7-c56b05ace2d7}']
        function GetSupportedActionTypes(out pdwActions: TCDBE_ACTIONS): HResult; stdcall;
    end;


{$ENDIF}// NTDDI_WINXP



    IContextMenuSite = interface(IUnknown)
        ['{0811AEBE-0B87-4C54-9E72-548CF649016B}']
        function DoContextMenuPopup(punkContextMenu: IUnknown; fFlags: UINT; pt: TPOINT): HResult; stdcall;
    end;


    IEnumReadyCallback = interface(IUnknown)
        ['{61E00D45-8FFF-4e60-924E-6537B61612DD}']
        function EnumReady(): HResult; stdcall;
    end;


    IEnumerableView = interface(IUnknown)
        ['{8C8BF236-1AEC-495f-9894-91D57C3C686F}']
        function SetEnumReadyCallback(percb: IEnumReadyCallback): HResult; stdcall;
        function CreateEnumIDListFromContents(pidlFolder: PCIDLIST_ABSOLUTE; dwEnumFlags: DWORD;
            out ppEnumIDList: IEnumIDList): HResult; stdcall;
    end;




{$IF  (NTDDI_VERSION >= NTDDI_WINXP)  OR  (_WIN32_IE >= _WIN32_IE_IE70)}

    IInsertItem = interface(IUnknown)
        ['{D2B57227-3D23-4b95-93C0-492BD454C356}']
        function InsertItem(pidl: PCUIDLIST_RELATIVE): HResult; stdcall;

    end;


{$IF  (NTDDI_VERSION >= NTDDI_WINXP)}



    TMENUBANDHANDLERCID = (
        MBHANDCID_PIDLSELECT = 0
        );




    IMenuBand = interface(IUnknown)
        ['{568804CD-CBD7-11d0-9816-00C04FD91972}']
        function IsMenuMessage(pmsg: PMSG): HResult; stdcall;
        function TranslateMenuMessage(var pmsg: MSG; out plRet: LRESULT): HResult; stdcall;
    end;




    IFolderBandPriv = interface(IUnknown)
        ['{47c01f95-e185-412c-b5c5-4f27df965aea}']
        function SetCascade(fCascade: boolean): HResult; stdcall;
        function SetAccelerators(fAccelerators: boolean): HResult; stdcall;
        function SetNoIcons(fNoIcons: boolean): HResult; stdcall;
        function SetNoText(fNoText: boolean): HResult; stdcall;
    end;




    IRegTreeItem = interface(IUnknown)
        ['{A9521922-0812-4d44-9EC3-7FD38C726F3D}']
        function GetCheckState(out pbCheck: boolean): HResult; stdcall;
        function SetCheckState(bCheck: boolean): HResult; stdcall;
    end;



    IImageRecompress = interface(IUnknown)
        ['{505f1513-6b3e-4892-a272-59f8889a4d3e}']
        function RecompressImage(psi: IShellItem; cx: int32; cy: int32; iQuality: int32; pstg: IStorage;
            out ppstrmOut: IStream): HResult; stdcall;
    end;


{$ENDIF}// NTDDI_WINXP
{$ENDIF}// NTDDI_WINXP)  OR  (_WIN32_IE >= _WIN32_IE_IE70)




{$IF  (_WIN32_IE >= _WIN32_IE_IE60)}
    IDeskBar = interface(IOleWindow)
        ['{EB0FE173-1A3A-11D0-89B3-00A0C90A90AC}']
        function SetClient(punkClient: IUnknown): HResult; stdcall;
        function GetClient(out ppunkClient: IUnknown): HResult; stdcall;
        function OnPosRectChangeDB(prc: PRECT): HResult; stdcall;
    end;


    TMENUPOPUPSELECT = (
        MPOS_EXECUTE = 0,
        MPOS_FULLCANCEL = (MPOS_EXECUTE + 1),
        MPOS_CANCELLEVEL = (MPOS_FULLCANCEL + 1),
        MPOS_SELECTLEFT = (MPOS_CANCELLEVEL + 1),
        MPOS_SELECTRIGHT = (MPOS_SELECTLEFT + 1),
        MPOS_CHILDTRACKING = (MPOS_SELECTRIGHT + 1)
        );

    TMENUPOPUPPOPUPFLAGS = (
        MPPF_SETFOCUS = $1,
        MPPF_INITIALSELECT = $2,
        MPPF_NOANIMATE = $4,
        MPPF_KEYBOARD = $10,
        MPPF_REPOSITION = $20,
        MPPF_FORCEZORDER = $40,
        MPPF_FINALSELECT = $80,
        MPPF_TOP = $20000000,
        MPPF_LEFT = $40000000,
        MPPF_RIGHT = $60000000,
        MPPF_BOTTOM = int32($80000000),
        MPPF_POS_MASK = int32($e0000000),
        MPPF_ALIGN_LEFT = $2000000,
        MPPF_ALIGN_RIGHT = $4000000
        );

    TMP_POPUPFLAGS = int32;


    IMenuPopup = interface(IDeskBar)
        ['{D1E7AFEB-6A2E-11d0-8C78-00C04FD918B4}']
        function Popup(ppt: PPOINTL; prcExclude: PRECTL; dwFlags: TMP_POPUPFLAGS): HResult; stdcall;
        function OnSelect(dwSelectType: DWORD): HResult; stdcall;
        function SetSubMenu(pmp: IMenuPopup; fSet: boolean): HResult; stdcall;
    end;


{$ENDIF}// _WIN32_IE_IE60



{$IF  (_WIN32_IE >= _WIN32_IE_IE70)}
    IInitializeWithBindCtx = interface(IUnknown)
        ['{71c0d2bc-726d-45cc-a6c0-2e31c1db2159}']
        function Initialize(pbc: IBindCtx): HResult; stdcall;
    end;


    IShellItemFilter = interface(IUnknown)
        ['{2659B475-EEB8-48b7-8F07-B378810F48CF}']
        function IncludeItem(psi: IShellItem): HResult; stdcall;
        function GetEnumFlagsForItem(psi: IShellItem; out pgrfFlags: TSHCONTF): HResult; stdcall;
    end;

{$ENDIF}// (_WIN32_IE >= _WIN32_IE_IE70)


{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    TFILE_USAGE_TYPE = (
        FUT_PLAYING = 0,
        FUT_EDITING = (FUT_PLAYING + 1),
        FUT_GENERIC = (FUT_EDITING + 1)
        );

const
    OF_CAP_CANSWITCHTO = $0001;
    OF_CAP_CANCLOSE = $0002;




type
    IFileIsInUse = interface(IUnknown)
        ['{64a1cbf0-3a1a-4461-9158-376969693950}']
        function GetAppName(out ppszName: LPWSTR): HResult; stdcall;
        function GetUsage(out pfut: TFILE_USAGE_TYPE): HResult; stdcall;
        function GetCapabilities(out pdwCapFlags: DWORD): HResult; stdcall;
        function GetSwitchToHWND(out phwnd: HWND): HResult; stdcall;
        function CloseFile(): HResult; stdcall;
    end;


    TFDE_OVERWRITE_RESPONSE = (
        FDEOR_DEFAULT = 0,
        FDEOR_ACCEPT = 1,
        FDEOR_REFUSE = 2
        );

    TFDE_SHAREVIOLATION_RESPONSE = (
        FDESVR_DEFAULT = 0,
        FDESVR_ACCEPT = 1,
        FDESVR_REFUSE = 2
        );

    TFDAP = (
        FDAP_BOTTOM = 0,
        FDAP_TOP = 1
        );


    IFileDialog = interface;

    IFileDialogEvents = interface(IUnknown)
        ['{973510db-7d7f-452b-8975-74a85828d354}']
        function OnFileOk(pfd: IFileDialog): HResult; stdcall;
        function OnFolderChanging(pfd: IFileDialog; psiFolder: IShellItem): HResult; stdcall;
        function OnFolderChange(pfd: IFileDialog): HResult; stdcall;
        function OnSelectionChange(pfd: IFileDialog): HResult; stdcall;
        function OnShareViolation(pfd: IFileDialog; psi: IShellItem; out pResponse: TFDE_SHAREVIOLATION_RESPONSE): HResult; stdcall;
        function OnTypeChange(pfd: IFileDialog): HResult; stdcall;
        function OnOverwrite(pfd: IFileDialog; psi: IShellItem; out pResponse: TFDE_OVERWRITE_RESPONSE): HResult; stdcall;
    end;



    TFILEOPENDIALOGOPTIONS = (
        FOS_OVERWRITEPROMPT = DWORD($2),
        FOS_STRICTFILETYPES = $4,
        FOS_NOCHANGEDIR = $8,
        FOS_PICKFOLDERS = $20,
        FOS_FORCEFILESYSTEM = $40,
        FOS_ALLNONSTORAGEITEMS = $80,
        FOS_NOVALIDATE = $100,
        FOS_ALLOWMULTISELECT = $200,
        FOS_PATHMUSTEXIST = $800,
        FOS_FILEMUSTEXIST = $1000,
        FOS_CREATEPROMPT = $2000,
        FOS_SHAREAWARE = $4000,
        FOS_NOREADONLYRETURN = $8000,
        FOS_NOTESTFILECREATE = $10000,
        FOS_HIDEMRUPLACES = $20000,
        FOS_HIDEPINNEDPLACES = $40000,
        FOS_NODEREFERENCELINKS = $100000,
        FOS_DONTADDTORECENT = $2000000,
        FOS_FORCESHOWHIDDEN = $10000000,
        FOS_DEFAULTNOMINIMODE = $20000000,
        FOS_FORCEPREVIEWPANEON = $40000000,
        FOS_SUPPORTSTREAMABLEITEMS = $80000000
        );



    IFileDialog = interface(IModalWindow)
        ['{42f85136-db7e-439c-85f1-e4075d135fc8}']
        function SetFileTypes(cFileTypes: UINT; rgFilterSpec: PCOMDLG_FILTERSPEC): HResult; stdcall;
        function SetFileTypeIndex(iFileType: UINT): HResult; stdcall;
        function GetFileTypeIndex(out piFileType: UINT): HResult; stdcall;
        function Advise(pfde: IFileDialogEvents; out pdwCookie: DWORD): HResult; stdcall;
        function Unadvise(dwCookie: DWORD): HResult; stdcall;
        function SetOptions(fos: TFILEOPENDIALOGOPTIONS): HResult; stdcall;
        function GetOptions(out pfos: TFILEOPENDIALOGOPTIONS): HResult; stdcall;
        function SetDefaultFolder(psi: IShellItem): HResult; stdcall;
        function SetFolder(psi: IShellItem): HResult; stdcall;
        function GetFolder(out ppsi: IShellItem): HResult; stdcall;
        function GetCurrentSelection(out ppsi: IShellItem): HResult; stdcall;
        function SetFileName(pszName: LPCWSTR): HResult; stdcall;
        function GetFileName(out pszName: LPWSTR): HResult; stdcall;
        function SetTitle(pszTitle: LPCWSTR): HResult; stdcall;
        function SetOkButtonLabel(pszText: LPCWSTR): HResult; stdcall;
        function SetFileNameLabel(pszLabel: LPCWSTR): HResult; stdcall;
        function GetResult(out ppsi: IShellItem): HResult; stdcall;
        function AddPlace(psi: IShellItem; fdap: TFDAP): HResult; stdcall;
        function SetDefaultExtension(pszDefaultExtension: LPCWSTR): HResult; stdcall;
        function Close(hr: HRESULT): HResult; stdcall;
        function SetClientGuid(const guid: TGUID): HResult; stdcall;
        function ClearClientData(): HResult; stdcall;
        function SetFilter(pFilter: IShellItemFilter): HResult; stdcall;
    end;


    IFileSaveDialog = interface(IFileDialog)
        ['{84bccd23-5fde-4cdb-aea4-af64b83d78ab}']
        function SetSaveAsItem(psi: IShellItem): HResult; stdcall;
        function SetProperties(pStore: IPropertyStore): HResult; stdcall;
        function SetCollectedProperties(pList: IPropertyDescriptionList; fAppendDefault: boolean): HResult; stdcall;
        function GetProperties(out ppStore: IPropertyStore): HResult; stdcall;
        function ApplyProperties(psi: IShellItem; pStore: IPropertyStore; hwnd: HWND;
            pSink: IFileOperationProgressSink): HResult; stdcall;
    end;



    IFileOpenDialog = interface(IFileDialog)
        ['{d57c7288-d4ad-4768-be02-9d969532d960}']
        function GetResults(out ppenum: IShellItemArray): HResult; stdcall;
        function GetSelectedItems(out ppsai: IShellItemArray): HResult; stdcall;
    end;

    TCDCONTROLSTATEF = (
        CDCS_INACTIVE = 0,
        CDCS_ENABLED = $1,
        CDCS_VISIBLE = $2,
        CDCS_ENABLEDVISIBLE = $3
        );


    IFileDialogCustomize = interface(IUnknown)
        ['{e6fdd21a-163f-4975-9c8c-a69f1ba37034}']
        function EnableOpenDropDown(dwIDCtl: DWORD): HResult; stdcall;
        function AddMenu(dwIDCtl: DWORD; pszLabel: LPCWSTR): HResult; stdcall;
        function AddPushButton(dwIDCtl: DWORD; pszLabel: LPCWSTR): HResult; stdcall;
        function AddComboBox(dwIDCtl: DWORD): HResult; stdcall;
        function AddRadioButtonList(dwIDCtl: DWORD): HResult; stdcall;
        function AddCheckButton(dwIDCtl: DWORD; pszLabel: LPCWSTR; bChecked: boolean): HResult; stdcall;
        function AddEditBox(dwIDCtl: DWORD; pszText: LPCWSTR): HResult; stdcall;
        function AddSeparator(dwIDCtl: DWORD): HResult; stdcall;
        function AddText(dwIDCtl: DWORD; pszText: LPCWSTR): HResult; stdcall;
        function SetControlLabel(dwIDCtl: DWORD; pszLabel: LPCWSTR): HResult; stdcall;
        function GetControlState(dwIDCtl: DWORD; out pdwState: TCDCONTROLSTATEF): HResult; stdcall;
        function SetControlState(dwIDCtl: DWORD; dwState: TCDCONTROLSTATEF): HResult; stdcall;
        function GetEditBoxText(dwIDCtl: DWORD; out ppszText: PWCHAR): HResult; stdcall;
        function SetEditBoxText(dwIDCtl: DWORD; pszText: LPCWSTR): HResult; stdcall;
        function GetCheckButtonState(dwIDCtl: DWORD; out pbChecked: boolean): HResult; stdcall;
        function SetCheckButtonState(dwIDCtl: DWORD; bChecked: boolean): HResult; stdcall;
        function AddControlItem(dwIDCtl: DWORD; dwIDItem: DWORD; pszLabel: LPCWSTR): HResult; stdcall;
        function RemoveControlItem(dwIDCtl: DWORD; dwIDItem: DWORD): HResult; stdcall;
        function RemoveAllControlItems(dwIDCtl: DWORD): HResult; stdcall;
        function GetControlItemState(dwIDCtl: DWORD; dwIDItem: DWORD; out pdwState: TCDCONTROLSTATEF): HResult; stdcall;
        function SetControlItemState(dwIDCtl: DWORD; dwIDItem: DWORD; dwState: TCDCONTROLSTATEF): HResult; stdcall;
        function GetSelectedControlItem(dwIDCtl: DWORD; out pdwIDItem: DWORD): HResult; stdcall;
        function SetSelectedControlItem(dwIDCtl: DWORD; dwIDItem: DWORD): HResult; stdcall;
        function StartVisualGroup(dwIDCtl: DWORD; pszLabel: LPCWSTR): HResult; stdcall;
        function EndVisualGroup(): HResult; stdcall;
        function MakeProminent(dwIDCtl: DWORD): HResult; stdcall;
        function SetControlItemText(dwIDCtl: DWORD; dwIDItem: DWORD; pszLabel: LPCWSTR): HResult; stdcall;
    end;


    IFileDialogControlEvents = interface(IUnknown)
        ['{36116642-D713-4b97-9B83-7484A9D00433}']
        function OnItemSelected(pfdc: IFileDialogCustomize; dwIDCtl: DWORD; dwIDItem: DWORD): HResult; stdcall;
        function OnButtonClicked(pfdc: IFileDialogCustomize; dwIDCtl: DWORD): HResult; stdcall;
        function OnCheckButtonToggled(pfdc: IFileDialogCustomize; dwIDCtl: DWORD; bChecked: boolean): HResult; stdcall;
        function OnControlActivating(pfdc: IFileDialogCustomize; dwIDCtl: DWORD): HResult; stdcall;
    end;



    IFileDialog2 = interface(IFileDialog)
        ['{61744fc7-85b5-4791-a9b0-272276309b13}']
        function SetCancelButtonLabel(pszLabel: LPCWSTR): HResult; stdcall;
        function SetNavigationRoot(psi: IShellItem): HResult; stdcall;
    end;


    TASSOCIATIONLEVEL = (
        AL_MACHINE = 0,
        AL_EFFECTIVE = (AL_MACHINE + 1),
        AL_USER = (AL_EFFECTIVE + 1)
        );

    TASSOCIATIONTYPE = (
        AT_FILEEXTENSION = 0,
        AT_URLPROTOCOL = (AT_FILEEXTENSION + 1),
        AT_STARTMENUCLIENT = (AT_URLPROTOCOL + 1),
        AT_MIMETYPE = (AT_STARTMENUCLIENT + 1)
        );


    IApplicationAssociationRegistration = interface(IUnknown)
        ['{4e530b0a-e611-4c77-a3ac-9031d022281b}']
        function QueryCurrentDefault(pszQuery: LPCWSTR; atQueryType: TASSOCIATIONTYPE; alQueryLevel: TASSOCIATIONLEVEL;
            out ppszAssociation: LPWSTR): HResult; stdcall;
        function QueryAppIsDefault(pszQuery: LPCWSTR; atQueryType: TASSOCIATIONTYPE; alQueryLevel: TASSOCIATIONLEVEL;
            pszAppRegistryName: LPCWSTR; out pfDefault: boolean): HResult; stdcall;
        function QueryAppIsDefaultAll(alQueryLevel: TASSOCIATIONLEVEL; pszAppRegistryName: LPCWSTR;
            out pfDefault: boolean): HResult; stdcall;
        function SetAppAsDefault(pszAppRegistryName: LPCWSTR; pszSet: LPCWSTR; atSetType: TASSOCIATIONTYPE): HResult; stdcall;
        function SetAppAsDefaultAll(pszAppRegistryName: LPCWSTR): HResult; stdcall;
        function ClearUserAssociations(): HResult; stdcall;
    end;




    IApplicationAssociationRegistrationUI = interface(IUnknown)
        ['{1f76a169-f994-40ac-8fc8-0959e8874710}']
        function LaunchAdvancedAssociationUI(pszAppRegistryName: LPCWSTR): HResult; stdcall;
    end;


{$ENDIF}// NTDDI_VISTA




    //include <pshpack1.h>
{$Z1}
    TDELEGATEITEMID = record
        cbSize: word;
        wOuter: word;
        cbInner: word;
        rgb: PBYTE;
    end;

    //include <poppack.h>
{$Z4}
    PDELEGATEITEMID = ^TDELEGATEITEMID;


    IDelegateFolder = interface(IUnknown)
        ['{ADD8BA80-002B-11D0-8F0F-00C04FD7D062}']
        function SetItemAlloc(pmalloc: IMalloc): HResult; stdcall;
    end;



{$IF  (_WIN32_IE >= _WIN32_IE_IE60)}
    // INTERFACE: IBrowserFrameOptions

    // This interface was implemented so a browser or host can ask a ShellView/ShelNameSpace what
    // kind of 'Behavior' is appropriate for that view.

    //    IBrowserFrameOptions::GetBrowserOptions()
    //       dwMask is the logical OR of bits to look for.  pdwOptions is not optional and
    //       it's return value will always equal or will be a subset of dwMask.
    //       If the function succeeds, the return value must be S_OK and pdwOptions needs to be filled in.
    //       If the function fails, pdwOptions needs to be filled in with BFO_NONE.




    TBROWSERFRAMEOPTIONS = (
        BFO_NONE = DWORD(0),
        BFO_BROWSER_PERSIST_SETTINGS = $1,
        BFO_RENAME_FOLDER_OPTIONS_TOINTERNET = $2,
        BFO_BOTH_OPTIONS = $4,
        BIF_PREFER_INTERNET_SHORTCUT = $8,
        BFO_BROWSE_NO_IN_NEW_PROCESS = $10,
        BFO_ENABLE_HYPERLINK_TRACKING = $20,
        BFO_USE_IE_OFFLINE_SUPPORT = $40,
        BFO_SUBSTITUE_INTERNET_START_PAGE = $80,
        BFO_USE_IE_LOGOBANDING = $100,
        BFO_ADD_IE_TOCAPTIONBAR = $200,
        BFO_USE_DIALUP_REF = $400,
        BFO_USE_IE_TOOLBAR = $800,
        BFO_NO_PARENT_FOLDER_SUPPORT = $1000,
        BFO_NO_REOPEN_NEXT_RESTART = $2000,
        BFO_GO_HOME_PAGE = $4000,
        BFO_PREFER_IEPROCESS = $8000,
        BFO_SHOW_NAVIGATION_CANCELLED = $10000,
        BFO_USE_IE_STATUSBAR = $20000,
        BFO_QUERY_ALL = int32($ffffffff)
        );




    IBrowserFrameOptions = interface(IUnknown)
        ['{10DF43C8-1DBE-11d3-8B34-006097DF5BD4}']
        function GetFrameOptions(dwMask: TBROWSERFRAMEOPTIONS; out pdwOptions: TBROWSERFRAMEOPTIONS): HResult; stdcall;
    end;

    PIBrowserFrameOptions = ^IBrowserFrameOptions;


{$ENDIF}// _WIN32_IE_IE60




{$IF  (_WIN32_IE >= _WIN32_IE_IE60SP2)}

    TNWMF = (
        NWMF_UNLOADING = $1,
        NWMF_USERINITED = $2,
        NWMF_FIRST = $4,
        NWMF_OVERRIDEKEY = $8,
        NWMF_SHOWHELP = $10,
        NWMF_HTMLDIALOG = $20,
        NWMF_FROMDIALOGCHILD = $40,
        NWMF_USERREQUESTED = $80,
        NWMF_USERALLOWED = $100,
        NWMF_FORCEWINDOW = $10000,
        NWMF_FORCETAB = $20000,
        NWMF_SUGGESTWINDOW = $40000,
        NWMF_SUGGESTTAB = $80000,
        NWMF_INACTIVETAB = $100000
        );




    INewWindowManager = interface(IUnknown)
        ['{D2BC4C84-3F72-4a52-A604-7BCBF3982CBB}']
        function EvaluateNewWindow(pszUrl: LPCWSTR; pszName: LPCWSTR; pszUrlContext: LPCWSTR; pszFeatures: LPCWSTR;
            fReplace: boolean; dwFlags: DWORD; dwUserActionTime: DWORD): HResult; stdcall;

    end;



    TATTACHMENT_PROMPT = (
        ATTACHMENT_PROMPT_NONE = 0,
        ATTACHMENT_PROMPT_SAVE = $1,
        ATTACHMENT_PROMPT_EXEC = $2,
        ATTACHMENT_PROMPT_EXEC_OR_SAVE = $3
        );

    TATTACHMENT_ACTION = (
        ATTACHMENT_ACTION_CANCEL = 0,
        ATTACHMENT_ACTION_SAVE = $1,
        ATTACHMENT_ACTION_EXEC = $2
        );




    IAttachmentExecute = interface(IUnknown)
        ['{73db1241-1e85-4581-8e4f-a81e1d0f8c57}']
        function SetClientTitle(pszTitle: LPCWSTR): HResult; stdcall;
        function SetClientGuid(const guid: TGUID): HResult; stdcall;
        function SetLocalPath(pszLocalPath: LPCWSTR): HResult; stdcall;
        function SetFileName(pszFileName: LPCWSTR): HResult; stdcall;
        function SetSource(pszSource: LPCWSTR): HResult; stdcall;
        function SetReferrer(pszReferrer: LPCWSTR): HResult; stdcall;
        function CheckPolicy(): HResult; stdcall;
        function Prompt(hwnd: HWND; prompt: TATTACHMENT_PROMPT; out paction: TATTACHMENT_ACTION): HResult; stdcall;
        function Save(): HResult; stdcall;
        function Execute(hwnd: HWND; pszVerb: LPCWSTR; out phProcess: HANDLE): HResult; stdcall;
        function SaveWithUI(hwnd: HWND): HResult; stdcall;
        function ClearClientState(): HResult; stdcall;
    end;

{$ENDIF}// _WIN32_IE_IE60SP2



{$IF  (_WIN32_IE >= _WIN32_IE_IE60)}
    //include <pshpack8.h>
{$Z8}
    TSMDATA = record
        dwMask: DWORD;
        dwFlags: DWORD;
        hmenu: HMENU;
        hwnd: HWND;
        uId: UINT;
        uIdParent: UINT;
        uIdAncestor: UINT;
        punk: IUnknown;
        pidlFolder: PIDLIST_ABSOLUTE;
        pidlItem: PUITEMID_CHILD;
        psf: IShellFolder;
        pvUserData: pointer;
    end;
    PSMDATA = ^TSMDATA;


// Mask
const
    SMDM_SHELLFOLDER = $00000001;  // This is for an item in the band
    SMDM_HMENU = $00000002;  // This is for the Band itself
    SMDM_TOOLBAR = $00000004; // Plain toolbar, not associated with a shell folder or hmenu
// Flags (bitmask)
type
    TSMINFO = record
        dwMask: DWORD;
        dwType: DWORD;
        dwFlags: DWORD;
        iIcon: int32;
    end;
    PSMINFO = ^TSMINFO;



    TSHCSCHANGENOTIFYSTRUCT = record
        lEvent: long;
        pidl1: PCIDLIST_ABSOLUTE;
        pidl2: PCIDLIST_ABSOLUTE;
    end;
    PSMCSHCHANGENOTIFYSTRUCT = ^TSHCSCHANGENOTIFYSTRUCT;


    //include <poppack.h>
{$Z4}

    TSMINFOMASK = (
        SMIM_TYPE = $1,
        SMIM_FLAGS = $2,
        SMIM_ICON = $4
        );

    TSMINFOTYPE = (
        SMIT_SEPARATOR = $1,
        SMIT_STRING = $2
        );

    TSMINFOFLAGS = (
        SMIF_ICON = $1,
        SMIF_ACCELERATOR = $2,
        SMIF_DROPTARGET = $4,
        SMIF_SUBMENU = $8,
        SMIF_CHECKED = $20,
        SMIF_DROPCASCADE = $40,
        SMIF_HIDDEN = $80,
        SMIF_DISABLED = $100,
        SMIF_TRACKPOPUP = $200,
        SMIF_DEMOTED = $400,
        SMIF_ALTSTATE = $800,
        SMIF_DRAGNDROP = $1000,
        SMIF_NEW = $2000
        );

const
    SMC_INITMENU = $00000001;  // The callback is called to init a menuband
    SMC_CREATE = $00000002;
    SMC_EXITMENU = $00000003; // The callback is called when menu is collapsing
    SMC_GETINFO = $00000005; // The callback is called to return DWORD values
    SMC_GETSFINFO = $00000006;  // The callback is called to return DWORD values
    SMC_GETOBJECT = $00000007;  // The callback is called to get some object
    SMC_GETSFOBJECT = $00000008;  // The callback is called to get some object
    SMC_SFEXEC = $00000009;  // The callback is called to execute an shell folder item
    SMC_SFSELECTITEM = $0000000A;  // The callback is called when an item is selected
    SMC_REFRESH = $00000010;  // Menus have completely refreshed. Reset your state.
    SMC_DEMOTE = $00000011;  // Demote an item
    SMC_PROMOTE = $00000012;  // Promote an item, wParam = SMINV_* flag
    SMC_DEFAULTICON = $00000016;  // Returns Default icon location in wParam, index in lParam
    SMC_NEWITEM = $00000017;  // Notifies item is not in the order stream.
    SMC_CHEVRONEXPAND = $00000019;  // Notifies of a expansion via the chevron
    SMC_DISPLAYCHEVRONTIP = $0000002A;  // S_OK display, S_FALSE not.
    SMC_SETSFOBJECT = $0000002D;  // Called to save the passed object
    SMC_SHCHANGENOTIFY = $0000002E;  // Called when a Change notify is received. lParam points to SMCSHCHANGENOTIFYSTRUCT
    SMC_CHEVRONGETTIP = $0000002F;  // Called to get the chevron tip text. wParam = Tip title, Lparam = TipText Both MAX_PATH
    SMC_SFDDRESTRICTED = $00000030;  // Called requesting if it's ok to drop. wParam = IDropTarget.
{$IF  (_WIN32_IE >= _WIN32_IE_IE70)}
    SMC_SFEXEC_MIDDLE = $00000031;  // Same as SFEXEC, but the middle mouse button caused the exec.
    SMC_GETAUTOEXPANDSTATE = $00000041;  // callback returns the default autoexpand state lParam = LPDWORD to recieve flags
    SMC_AUTOEXPANDCHANGE = $00000042; // Notify that the menu is expanding/contracting
    SMC_GETCONTEXTMENUMODIFIER = $00000043;  // Used to add items to a context menu
    SMC_GETBKCONTEXTMENU = $00000044;  // used to get a context menu to display when user right clicks on the background
    SMC_OPEN = $00000045;  // allows client to overwrite open/explore verb action on an item
    // Flags for return value from SMC_GETAUTOEXPANDSTATE and SMC_AUTOEXPANDCHANGE:
    SMAE_EXPANDED = $00000001; // The menu is or should start expanded
    SMAE_CONTRACTED = $00000002; // The menu is or should start contracted
    // SMAE_EXPANDED and SMAE_CONTRACTED are mutually exclusive
    SMAE_USER = $00000004;  // Indicates that the menu expansion/contraction is a reflection
    // of user choice
    SMAE_VALID = $00000007;
{$ENDIF}// _WIN32_IE_IE70



type
    IShellMenuCallback = interface(IUnknown)
        ['{4CA300A1-9B8D-11d1-8B22-00C04FD918D0}']
        function CallbackSM(var psmd: TSMDATA; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): HResult; stdcall;
    end;




const
    SMINIT_DEFAULT = $00000000;  // No Options
    SMINIT_RESTRICT_DRAGDROP = $00000002; // Don't allow Drag and Drop
    SMINIT_TOPLEVEL = $00000004;  // This is the top band.
    SMINIT_CACHED = $00000010;
{$IF  (_WIN32_IE >= _WIN32_IE_IE70)}
    SMINIT_AUTOEXPAND = $00000100; // automatically expand/contract menu band
    SMINIT_AUTOTOOLTIP = $00000200;  // regular tooltip support
    SMINIT_DROPONCONTAINER = $00000400;  // allow drop on a container
{$ENDIF}// _WIN32_IE_IE70
    SMINIT_VERTICAL = $10000000;  // This is a vertical menu
    SMINIT_HORIZONTAL = $20000000;  // This is a horizontal menu    (does not inherit)
    ANCESTORDEFAULT = UINT(-1);
    SMSET_TOP = $10000000;    // Bias this namespace to the top of the menu
    SMSET_BOTTOM = $20000000;    // Bias this namespace to the bottom of the menu
    SMSET_DONTOWN = $00000001;    // The Menuband doesn't own the non-ref counted object
    SMINV_REFRESH = $00000001;
    SMINV_ID = $00000008;



type
    IShellMenu = interface(IUnknown)
        ['{EE1F7637-E138-11d1-8379-00C04FD918D0}']
        function Initialize(psmc: IShellMenuCallback; uId: UINT; uIdAncestor: UINT; dwFlags: DWORD): HResult; stdcall;
        function GetMenuInfo(out ppsmc: IShellMenuCallback; out puId: UINT; out puIdAncestor: UINT; out pdwFlags: DWORD): HResult; stdcall;
        function SetShellFolder(psf: IShellFolder; pidlFolder: PCIDLIST_ABSOLUTE; hKey: HKEY; dwFlags: DWORD): HResult; stdcall;
        function GetShellFolder(out pdwFlags: DWORD; out ppidl: PIDLIST_ABSOLUTE; const riid: TGUID; out ppv): HResult; stdcall;
        function SetMenu(hmenu: HMENU; hwnd: HWND; dwFlags: DWORD): HResult; stdcall;
        function GetMenu(out phmenu: HMENU; out phwnd: HWND; out pdwFlags: DWORD): HResult; stdcall;
        function InvalidateItem(const psmd: TSMDATA; dwFlags: DWORD): HResult; stdcall;
        function GetState(out psmd: TSMDATA): HResult; stdcall;
        function SetMenuToolbar(punk: IUnknown; dwFlags: DWORD): HResult; stdcall;
    end;


{$ENDIF}// _WIN32_IE_IE60


    IShellRunDll = interface(IUnknown)
        ['{fce4bde0-4b68-4b80-8e9c-7426315a7388}']
        function Run(pszArgs: LPCWSTR): HResult; stdcall;
    end;



{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
type
    TKF_CATEGORY = (
        KF_CATEGORY_VIRTUAL = 1,
        KF_CATEGORY_FIXED = 2,
        KF_CATEGORY_COMMON = 3,
        KF_CATEGORY_PERUSER = 4
        );


    TKF_DEFINITION_FLAGS = (
        KFDF_LOCAL_REDIRECT_ONLY = DWORD($2),
        KFDF_ROAMABLE = $4,
        KFDF_PRECREATE = $8,
        KFDF_STREAM = $10,
        KFDF_PUBLISHEXPANDEDPATH = $20,
        KFDF_NO_REDIRECT_UI = $40
        );


    TKF_REDIRECT_FLAGS = (
        KF_REDIRECT_USER_EXCLUSIVE = DWORD($1),
        KF_REDIRECT_COPY_SOURCE_DACL = $2,
        KF_REDIRECT_OWNER_USER = $4,
        KF_REDIRECT_SET_OWNER_EXPLICIT = $8,
        KF_REDIRECT_CHECK_ONLY = $10,
        KF_REDIRECT_WITH_UI = $20,
        KF_REDIRECT_UNPIN = $40,
        KF_REDIRECT_PIN = $80,
        KF_REDIRECT_COPY_CONTENTS = $200,
        KF_REDIRECT_DEL_SOURCE_CONTENTS = $400,
        KF_REDIRECT_EXCLUDE_ALL_KNOWN_SUBFOLDERS = $800
        );


    TKF_REDIRECTION_CAPABILITIES = (
        KF_REDIRECTION_CAPABILITIES_ALLOW_ALL = DWORD($ff),
        KF_REDIRECTION_CAPABILITIES_REDIRECTABLE = $1,
        KF_REDIRECTION_CAPABILITIES_DENY_ALL = $fff00,
        KF_REDIRECTION_CAPABILITIES_DENY_POLICY_REDIRECTED = $100,
        KF_REDIRECTION_CAPABILITIES_DENY_POLICY = $200,
        KF_REDIRECTION_CAPABILITIES_DENY_PERMISSIONS = $400
        );


    TKNOWNFOLDER_DEFINITION = record
        category: TKF_CATEGORY;
        pszName: LPWSTR;
        pszDescription: LPWSTR;
        fidParent: TKNOWNFOLDERID;
        pszRelativePath: LPWSTR;
        pszParsingName: LPWSTR;
        pszTooltip: LPWSTR;
        pszLocalizedName: LPWSTR;
        pszIcon: LPWSTR;
        pszSecurity: LPWSTR;
        dwAttributes: DWORD;
        kfdFlags: TKF_DEFINITION_FLAGS;
        ftidType: TFOLDERTYPEID;
    end;




    IKnownFolder = interface(IUnknown)
        ['{3AA7AF7E-9B36-420c-A8E3-F77D4674A488}']
        function GetId(out pkfid: TKNOWNFOLDERID): HResult; stdcall;
        function GetCategory(out pCategory: TKF_CATEGORY): HResult; stdcall;
        function GetShellItem(dwFlags: DWORD; const riid: TGUID; out ppv): HResult; stdcall;
        function GetPath(dwFlags: DWORD; out ppszPath: LPWSTR): HResult; stdcall;
        function SetPath(dwFlags: DWORD; pszPath: LPCWSTR): HResult; stdcall;
        function GetIDList(dwFlags: DWORD; out ppidl: PIDLIST_ABSOLUTE): HResult; stdcall;
        function GetFolderType(out pftid: TFOLDERTYPEID): HResult; stdcall;
        function GetRedirectionCapabilities(out pCapabilities: TKF_REDIRECTION_CAPABILITIES): HResult; stdcall;
        function GetFolderDefinition(out pKFD: TKNOWNFOLDER_DEFINITION): HResult; stdcall;
    end;



    TFFFP_MODE = (
        FFFP_EXACTMATCH = 0,
        FFFP_NEARESTPARENTMATCH = (FFFP_EXACTMATCH + 1)
        );




    IKnownFolderManager = interface(IUnknown)
        ['{8BE2D872-86AA-4d47-B776-32CCA40C7018}']
        function FolderIdFromCsidl(nCsidl: int32; out pfid: TKNOWNFOLDERID): HResult; stdcall;
        function FolderIdToCsidl(const rfid: TKNOWNFOLDERID; out pnCsidl: int32): HResult; stdcall;
        function GetFolderIds(out ppKFId: PKNOWNFOLDERID; var pCount: UINT): HResult; stdcall;
        function GetFolder(const rfid: TKNOWNFOLDERID; out ppkf: IKnownFolder): HResult; stdcall;
        function GetFolderByName(pszCanonicalName: LPCWSTR; out ppkf: IKnownFolder): HResult; stdcall;
        function RegisterFolder(const rfid: TKNOWNFOLDERID; const pKFD: TKNOWNFOLDER_DEFINITION): HResult; stdcall;
        function UnregisterFolder(const rfid: TKNOWNFOLDERID): HResult; stdcall;
        function FindFolderFromPath(pszPath: LPCWSTR; mode: TFFFP_MODE; out ppkf: IKnownFolder): HResult; stdcall;
        function FindFolderFromIDList(pidl: PCIDLIST_ABSOLUTE; out ppkf: IKnownFolder): HResult; stdcall;
        function Redirect(const rfid: TKNOWNFOLDERID; hwnd: HWND; flags: TKF_REDIRECT_FLAGS; pszTargetPath: LPCWSTR;
            cFolders: UINT; pExclusion: PKNOWNFOLDERID; out ppszError: LPWSTR): HResult; stdcall;
    end;




    ISharingConfigurationManager = interface(IUnknown)
        ['{B4CD448A-9C86-4466-9201-2E62105B87AE}']
        function CreateShare(dsid: TDEF_SHARE_ID; role: TSHARE_ROLE): HResult; stdcall;
        function DeleteShare(dsid: TDEF_SHARE_ID): HResult; stdcall;
        function ShareExists(dsid: TDEF_SHARE_ID): HResult; stdcall;
        function GetSharePermissions(dsid: TDEF_SHARE_ID; out pRole: TSHARE_ROLE): HResult; stdcall;
        function SharePrinters(): HResult; stdcall;
        function StopSharingPrinters(): HResult; stdcall;
        function ArePrintersShared(): HResult; stdcall;
    end;


{$ENDIF}// NTDDI_VISTA


    IPreviousVersionsInfo = interface(IUnknown)
        ['{76e54780-ad74-48e3-a695-3ba9a0aff10d}']
        function AreSnapshotsAvailable(pszPath: LPCWSTR; fOkToBeSlow: boolean; out pfAvailable: boolean): HResult; stdcall;
    end;



    {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}


    IRelatedItem = interface(IUnknown)
        ['{a73ce67a-8ab1-44f1-8d43-d2fcbf6b1cd0}']
        function GetItemIDList(out ppidl: PIDLIST_ABSOLUTE): HResult; stdcall;
        function GetItem(out ppsi: IShellItem): HResult; stdcall;
    end;


    IIdentityName = interface(IRelatedItem)
        ['{7d903fca-d6f9-4810-8332-946c0177e247}']
    end;


    IDelegateItem = interface(IRelatedItem)
        ['{3c5a1c94-c951-4cb7-bb6d-3b93f30cce93}']
    end;


    ICurrentItem = interface(IRelatedItem)
        ['{240a7174-d653-4a1d-a6d3-d4943cfbfe3d}']
    end;


    ITransferMediumItem = interface(IRelatedItem)
        ['{77f295d5-2d6f-4e19-b8ae-322f3e721ab5}']
    end;


    IUseToBrowseItem = interface(IRelatedItem)
        ['{05edda5c-98a3-4717-8adb-c5e7da991eb1}']
    end;


    IDisplayItem = interface(IRelatedItem)
        ['{c6fd5997-9f6b-4888-8703-94e80e8cde3f}']
    end;


    IViewStateIdentityItem = interface(IRelatedItem)
        ['{9D264146-A94F-4195-9F9F-3BB12CE0C955}']
    end;


    IPreviewItem = interface(IRelatedItem)
        ['{36149969-0A8F-49c8-8B00-4AECB20222FB}']
    end;

    {$ENDIF}// NTDDI_VISTA

    IDestinationStreamFactory = interface(IUnknown)
        ['{8a87781b-39a7-4a1f-aab3-a39b9c34a7d9}']
        function GetDestinationStream(out ppstm: IStream): HResult; stdcall;
    end;




    {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}



    ICreateProcessInputs = interface(IUnknown)
        ['{F6EF6140-E26F-4D82-bAC4-E9BA5FD239A8}']
        function GetCreateFlags(out pdwCreationFlags: DWORD): HResult; stdcall;
        function SetCreateFlags(dwCreationFlags: DWORD): HResult; stdcall;
        function AddCreateFlags(dwCreationFlags: DWORD): HResult; stdcall;
        function SetHotKey(wHotKey: word): HResult; stdcall;
        function AddStartupFlags(dwStartupInfoFlags: DWORD): HResult; stdcall;
        function SetTitle(pszTitle: LPCWSTR): HResult; stdcall;
        function SetEnvironmentVariable(pszName: LPCWSTR; pszValue: LPCWSTR): HResult; stdcall;
    end;




    ICreatingProcess = interface(IUnknown)
        ['{c2b937a9-3110-4398-8a56-f34c6342d244}']
        function OnCreating(pcpi: ICreateProcessInputs): HResult; stdcall;
    end;

{$ENDIF}// NTDDI_VISTA


    TNMCII_FLAGS = (
        NMCII_NONE = int32(0),
        NMCII_ITEMS = $1,
        NMCII_FOLDERS = $2);

    TNMCSAEI_FLAGS = (
        NMCSAEI_SELECT = int32(0),
        NMCSAEI_EDIT = $1);


    INewMenuClient = interface(IUnknown)
        ['{dcb07fdc-3bb5-451c-90be-966644fed7b0}']
        function IncludeItems(out pflags: TNMCII_FLAGS): HResult; stdcall;
        function SelectAndEditItem(pidlItem: PCIDLIST_ABSOLUTE; flags: TNMCSAEI_FLAGS): HResult; stdcall;
    end;




    TNSTCSTYLE = (
        NSTCS_HASEXPANDOS = DWORD($1),
        NSTCS_HASLINES = $2,
        NSTCS_SINGLECLICKEXPAND = $4,
        NSTCS_FULLROWSELECT = $8,
        NSTCS_SPRINGEXPAND = $10,
        NSTCS_HORIZONTALSCROLL = $20,
        NSTCS_ROOTHASEXPANDO = $40,
        NSTCS_SHOWSELECTIONALWAYS = $80,
        NSTCS_NOINFOTIP = $200,
        NSTCS_EVENHEIGHT = $400,
        NSTCS_NOREPLACEOPEN = $800,
        NSTCS_DISABLEDRAGDROP = $1000,
        NSTCS_NOORDERSTREAM = $2000,
        NSTCS_RICHTOOLTIP = $4000,
        NSTCS_BORDER = $8000,
        NSTCS_NOEDITLABELS = $10000,
        NSTCS_TABSTOP = $20000,
        NSTCS_FAVORITESMODE = $80000,
        NSTCS_AUTOHSCROLL = $100000,
        NSTCS_FADEINOUTEXPANDOS = $200000,
        NSTCS_EMPTYTEXT = $400000,
        NSTCS_CHECKBOXES = $800000,
        NSTCS_PARTIALCHECKBOXES = $1000000,
        NSTCS_EXCLUSIONCHECKBOXES = $2000000,
        NSTCS_DIMMEDCHECKBOXES = $4000000,
        NSTCS_NOINDENTCHECKS = $8000000,
        NSTCS_ALLOWJUNCTIONS = $10000000,
        NSTCS_SHOWTABSBUTTON = $20000000,
        NSTCS_SHOWDELETEBUTTON = $40000000,
        NSTCS_SHOWREFRESHBUTTON = int32($80000000)
        );


    TNSTCROOTSTYLE = (
        NSTCRS_VISIBLE = DWORD(0),
        NSTCRS_HIDDEN = $1,
        NSTCRS_EXPANDED = $2
        );


    TNSTCITEMSTATE = (
        NSTCIS_NONE = 0,
        NSTCIS_SELECTED = $1,
        NSTCIS_EXPANDED = $2,
        NSTCIS_BOLD = $4,
        NSTCIS_DISABLED = $8,
        NSTCIS_SELECTEDNOEXPAND = $10
        );


    TNSTCGNI = (
        NSTCGNI_NEXT = DWORD(0),
        NSTCGNI_NEXTVISIBLE = 1,
        NSTCGNI_PREV = 2,
        NSTCGNI_PREVVISIBLE = 3,
        NSTCGNI_PARENT = 4,
        NSTCGNI_CHILD = 5,
        NSTCGNI_FIRSTVISIBLE = 6,
        NSTCGNI_LASTVISIBLE = 7
        );




    INameSpaceTreeControl = interface(IUnknown)
        ['{028212A3-B627-47e9-8856-C14265554E4F}']
        function Initialize(hwndParent: HWND; prc: PRECT; nsctsFlags: TNSTCSTYLE): HResult; stdcall;
        function TreeAdvise(punk: IUnknown; out pdwCookie: DWORD): HResult; stdcall;
        function TreeUnadvise(dwCookie: DWORD): HResult; stdcall;
        function AppendRoot(psiRoot: IShellItem; grfEnumFlags: TSHCONTF; grfRootStyle: TNSTCROOTSTYLE;
            pif: IShellItemFilter): HResult; stdcall;
        function InsertRoot(iIndex: int32; psiRoot: IShellItem; grfEnumFlags: TSHCONTF; grfRootStyle: TNSTCROOTSTYLE;
            pif: IShellItemFilter): HResult; stdcall;
        function RemoveRoot(psiRoot: IShellItem): HResult; stdcall;
        function RemoveAllRoots(): HResult; stdcall;
        function GetRootItems(out ppsiaRootItems: IShellItemArray): HResult; stdcall;
        function SetItemState(psi: IShellItem; nstcisMask: TNSTCITEMSTATE; nstcisFlags: TNSTCITEMSTATE): HResult; stdcall;
        function GetItemState(psi: IShellItem; nstcisMask: TNSTCITEMSTATE; out pnstcisFlags: TNSTCITEMSTATE): HResult; stdcall;
        function GetSelectedItems(out psiaItems: IShellItemArray): HResult; stdcall;
        function GetItemCustomState(psi: IShellItem; out piStateNumber: int32): HResult; stdcall;
        function SetItemCustomState(psi: IShellItem; iStateNumber: int32): HResult; stdcall;
        function EnsureItemVisible(psi: IShellItem): HResult; stdcall;
        function SetTheme(pszTheme: LPCWSTR): HResult; stdcall;
        function GetNextItem(psi: IShellItem; nstcgi: TNSTCGNI; out ppsiNext: IShellItem): HResult; stdcall;
        function HitTest(ppt: PPOINT; out ppsiOut: IShellItem): HResult; stdcall;
        function GetItemRect(psi: IShellItem; out prect: TRECT): HResult; stdcall;
        function CollapseAll(): HResult; stdcall;
    end;


    TNSTCSTYLE2 = (
        NSTCS2_DEFAULT = 0,
        NSTCS2_INTERRUPTNOTIFICATIONS = $1,
        NSTCS2_SHOWNULLSPACEMENU = $2,
        NSTCS2_DISPLAYPADDING = $4,
        NSTCS2_DISPLAYPINNEDONLY = $8,
        NTSCS2_NOSINGLETONAUTOEXPAND = $10,
        NTSCS2_NEVERINSERTNONENUMERATED = $20
        );


    INameSpaceTreeControl2 = interface(INameSpaceTreeControl)
        ['{7cc7aed8-290e-49bc-8945-c1401cc9306c}']
        function SetControlStyle(nstcsMask: TNSTCSTYLE; nstcsStyle: TNSTCSTYLE): HResult; stdcall;
        function GetControlStyle(nstcsMask: TNSTCSTYLE; out pnstcsStyle: TNSTCSTYLE): HResult; stdcall;
        function SetControlStyle2(nstcsMask: TNSTCSTYLE2; nstcsStyle: TNSTCSTYLE2): HResult; stdcall;
        function GetControlStyle2(nstcsMask: TNSTCSTYLE2; out pnstcsStyle: TNSTCSTYLE2): HResult; stdcall;
    end;


const
    NSTCS2_ALLMASK = (Ord(NSTCS2_INTERRUPTNOTIFICATIONS) or Ord(NSTCS2_SHOWNULLSPACEMENU) or Ord(NSTCS2_DISPLAYPADDING));

type
    TNSTCEHITTEST = (
        NSTCEHT_NOWHERE = DWORD($1),
        NSTCEHT_ONITEMICON = $2,
        NSTCEHT_ONITEMLABEL = $4,
        NSTCEHT_ONITEMINDENT = $8,
        NSTCEHT_ONITEMBUTTON = $10,
        NSTCEHT_ONITEMRIGHT = $20,
        NSTCEHT_ONITEMSTATEICON = $40,
        NSTCEHT_ONITEM = $46,
        NSTCEHT_ONITEMTABBUTTON = $1000
        );


    TNSTCECLICKTYPE = (
        NSTCECT_LBUTTON = DWORD($1),
        NSTCECT_MBUTTON = $2,
        NSTCECT_RBUTTON = $3,
        NSTCECT_BUTTON = $3,
        NSTCECT_DBLCLICK = $4
        );



    INameSpaceTreeControlEvents = interface(IUnknown)
        ['{93D77985-B3D8-4484-8318-672CDDA002CE}']
        function OnItemClick(psi: IShellItem; nstceHitTest: TNSTCEHITTEST; nstceClickType: TNSTCECLICKTYPE): HResult; stdcall;
        function OnPropertyItemCommit(psi: IShellItem): HResult; stdcall;
        function OnItemStateChanging(psi: IShellItem; nstcisMask: TNSTCITEMSTATE; nstcisState: TNSTCITEMSTATE): HResult; stdcall;
        function OnItemStateChanged(psi: IShellItem; nstcisMask: TNSTCITEMSTATE; nstcisState: TNSTCITEMSTATE): HResult; stdcall;
        function OnSelectionChanged(psiaSelection: IShellItemArray): HResult; stdcall;
        function OnKeyboardInput(uMsg: UINT; wParam: WPARAM; lParam: LPARAM): HResult; stdcall;
        function OnBeforeExpand(psi: IShellItem): HResult; stdcall;
        function OnAfterExpand(psi: IShellItem): HResult; stdcall;
        function OnBeginLabelEdit(psi: IShellItem): HResult; stdcall;
        function OnEndLabelEdit(psi: IShellItem): HResult; stdcall;
        function OnGetToolTip(psi: IShellItem; out pszTip: LPWSTR; cchTip: int32): HResult; stdcall;
        function OnBeforeItemDelete(psi: IShellItem): HResult; stdcall;
        function OnItemAdded(psi: IShellItem; fIsRoot: boolean): HResult; stdcall;
        function OnItemDeleted(psi: IShellItem; fIsRoot: boolean): HResult; stdcall;
        function OnBeforeContextMenu(psi: IShellItem; const riid: TGUID; out vppv): HResult; stdcall;
        function OnAfterContextMenu(psi: IShellItem; pcmIn: IContextMenu; const riid: TGUID; out ppv): HResult; stdcall;
        function OnBeforeStateImageChange(psi: IShellItem): HResult; stdcall;
        function OnGetDefaultIconIndex(psi: IShellItem; out piDefaultIcon: int32; out piOpenIcon: int32): HResult; stdcall;
    end;


const
    NSTCDHPOS_ONTOP = -1;

type
    INameSpaceTreeControlDropHandler = interface(IUnknown)
        ['{F9C665D6-C2F2-4c19-BF33-8322D7352F51}']
        function OnDragEnter(psiOver: IShellItem; psiaData: IShellItemArray; fOutsideSource: boolean; grfKeyState: DWORD;
            var pdwEffect: DWORD): HResult; stdcall;
        function OnDragOver(psiOver: IShellItem; psiaData: IShellItemArray; grfKeyState: DWORD; var pdwEffect: DWORD): HResult; stdcall;
        function OnDragPosition(psiOver: IShellItem; psiaData: IShellItemArray; iNewPosition: int32;
            iOldPosition: int32): HResult; stdcall;
        function OnDrop(psiOver: IShellItem; psiaData: IShellItemArray; iPosition: int32; grfKeyState: DWORD;
            var pdwEffect: DWORD): HResult; stdcall;
        function OnDropPosition(psiOver: IShellItem; psiaData: IShellItemArray; iNewPosition: int32;
            iOldPosition: int32): HResult; stdcall;
        function OnDragLeave(psiOver: IShellItem): HResult; stdcall;
    end;


    INameSpaceTreeAccessible = interface(IUnknown)
        ['{71f312de-43ed-4190-8477-e9536b82350b}']
        function OnGetDefaultAccessibilityAction(psi: IShellItem; out pbstrDefaultAction: BSTR): HResult; stdcall;
        function OnDoDefaultAccessibilityAction(psi: IShellItem): HResult; stdcall;
        function OnGetAccessibilityRole(psi: IShellItem; out pvarRole: variant): HResult; stdcall;
    end;


    TNSTCCUSTOMDRAW = record
        psi: IShellItem;
        uItemState: UINT;
        nstcis: TNSTCITEMSTATE;
        pszText: LPCWSTR;
        iImage: int32;
        himl: HIMAGELIST;
        iLevel: int32;
        iIndent: int32;
    end;
    PNSTCCUSTOMDRAW = ^TNSTCCUSTOMDRAW;


    INameSpaceTreeControlCustomDraw = interface(IUnknown)
        ['{2D3BA758-33EE-42d5-BB7B-5F3431D86C78}']
        function PrePaint(hdc: HDC; prc: PRECT; out plres: LRESULT): HResult; stdcall;
        function PostPaint(hdc: HDC; prc: PRECT): HResult; stdcall;
        function ItemPrePaint(hdc: HDC; prc: PRECT; pnstccdItem: PNSTCCUSTOMDRAW; var pclrText: TCOLORREF;
            var pclrTextBk: TCOLORREF; out plres: LRESULT): HResult; stdcall;
        function ItemPostPaint(hdc: HDC; prc: PRECT; pnstccdItem: PNSTCCUSTOMDRAW): HResult; stdcall;
    end;


 {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    TNSTCFOLDERCAPABILITIES = (
        NSTCFC_NONE = 0,
        NSTCFC_PINNEDITEMFILTERING = $1,
        NSTCFC_DELAY_REGISTER_NOTIFY = $2
        );


    INameSpaceTreeControlFolderCapabilities = interface(IUnknown)
        ['{e9701183-e6b3-4ff2-8568-813615fec7be}']
        function GetFolderCapabilities(nfcMask: TNSTCFOLDERCAPABILITIES; out pnfcValue: TNSTCFOLDERCAPABILITIES): HResult; stdcall;
    end;

{$ENDIF}// NTDDI_VISTA




const
    E_PREVIEWHANDLER_DRM_FAIL: HResult = ($86420001);
    E_PREVIEWHANDLER_NOAUTH: HResult = ($86420002);
    E_PREVIEWHANDLER_NOTFOUND: HResult = ($86420003);
    E_PREVIEWHANDLER_CORRUPT: HResult = ($86420004);




type
    IPreviewHandler = interface(IUnknown)
        ['{8895b1c6-b41f-4c1c-a562-0d564250836f}']
        function SetWindow(hwnd: HWND; const prc: TRECT): HResult; stdcall;
        function SetRect(const prc: TRECT): HResult; stdcall;
        function DoPreview(): HResult; stdcall;
        function Unload(): HResult; stdcall;
        function SetFocus(): HResult; stdcall;
        function QueryFocus(out phwnd: HWND): HResult; stdcall;
        function TranslateAccelerator(pmsg: PMSG): HResult; stdcall;
    end;


    TPREVIEWHANDLERFRAMEINFO = record
        haccel: HACCEL;
        cAccelEntries: UINT;
    end;




    IPreviewHandlerFrame = interface(IUnknown)
        ['{fec87aaf-35f9-447a-adb7-20234491401a}']
        function GetWindowContext(out pinfo: TPREVIEWHANDLERFRAMEINFO): HResult; stdcall;
        function TranslateAccelerator(const pmsg: TMSG): HResult; stdcall;
    end;



{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    ITrayDeskBand = interface(IUnknown)
        ['{6D67E846-5B9C-4db8-9CBC-DDE12F4254F1}']
        function ShowDeskBand(const clsid: TCLSID): HResult; stdcall;
        function HideDeskBand(const clsid: TCLSID): HResult; stdcall;
        function IsDeskBandShown(const clsid: TCLSID): HResult; stdcall;
        function DeskBandRegistrationChanged(): HResult; stdcall;
    end;


    IBandHost = interface(IUnknown)
        ['{B9075C7C-D48E-403f-AB99-D6C77A1084AC}']
        function CreateBand(const rclsidBand: TCLSID; fAvailable: boolean; fVisible: boolean; const riid: TGUID;
            out ppv): HResult; stdcall;
        function SetBandAvailability(const rclsidBand: TCLSID; fAvailable: boolean): HResult; stdcall;
        function DestroyBand(const rclsidBand: TCLSID): HResult; stdcall;
    end;


    TEXPLORERPANE = TGUID;


    TEXPLORERPANESTATE = (
        EPS_DONTCARE = DWORD(0),
        EPS_DEFAULT_ON = $1,
        EPS_DEFAULT_OFF = $2,
        EPS_STATEMASK = $ffff,
        EPS_INITIALSTATE = $10000,
        EPS_FORCE = $20000
        );


    IExplorerPaneVisibility = interface(IUnknown)
        ['{e07010ec-bc17-44c0-97b0-46c7c95b9edc}']
        function GetPaneState(const ep: TEXPLORERPANE; out peps: TEXPLORERPANESTATE): HResult; stdcall;
    end;


    IContextMenuCB = interface(IUnknown)
        ['{3409E930-5A39-11d1-83FA-00A0C90DC849}']
        function CallBack(psf: IShellFolder; hwndOwner: HWND; pdtobj: IDataObject; uMsg: UINT; wParam: WPARAM;
            lParam: LPARAM): HResult; stdcall;
    end;

{$ENDIF}// NTDDI_VISTA

    IDefaultExtractIconInit = interface(IUnknown)
        ['{41ded17d-d6b3-4261-997d-88c60e4b1d58}']
        function SetFlags(uFlags: UINT): HResult; stdcall;
        function SetKey(hkey: HKEY): HResult; stdcall;
        function SetNormalIcon(pszFile: LPCWSTR; iIcon: int32): HResult; stdcall;
        function SetOpenIcon(pszFile: LPCWSTR; iIcon: int32): HResult; stdcall;
        function SetShortcutIcon(pszFile: LPCWSTR; iIcon: int32): HResult; stdcall;
        function SetDefaultIcon(pszFile: LPCWSTR; iIcon: int32): HResult; stdcall;
    end;



function SHCreateDefaultExtractIcon(const riid: TGUID; out ppv): HResult; stdcall; external Shell32_dll;

type
    TEXPCMDSTATE = (
        ECS_ENABLED = DWORD(0),
        ECS_DISABLED = $1,
        ECS_HIDDEN = $2,
        ECS_CHECKBOX = $4,
        ECS_CHECKED = $8,
        ECS_RADIOCHECK = $10
        );


    TEXPCMDFLAGS = (
        ECF_DEFAULT = DWORD(0),
        ECF_HASSUBCOMMANDS = $1,
        ECF_HASSPLITBUTTON = $2,
        ECF_HIDELABEL = $4,
        ECF_ISSEPARATOR = $8,
        ECF_HASLUASHIELD = $10,
        ECF_SEPARATORBEFORE = $20,
        ECF_SEPARATORAFTER = $40,
        ECF_ISDROPDOWN = $80,
        ECF_TOGGLEABLE = $100,
        ECF_AUTOMENUICONS = $200
        );

    IEnumExplorerCommand = interface;

    IExplorerCommand = interface(IUnknown)
        ['{a08ce4d0-fa25-44ab-b57c-c7b1c323e0b9}']
        function GetTitle(psiItemArray: IShellItemArray; out ppszName: LPWSTR): HResult; stdcall;
        function GetIcon(psiItemArray: IShellItemArray; out ppszIcon: LPWSTR): HResult; stdcall;
        function GetToolTip(psiItemArray: IShellItemArray; out ppszInfotip: LPWSTR): HResult; stdcall;
        function GetCanonicalName(out pguidCommandName: TGUID): HResult; stdcall;
        function GetState(psiItemArray: IShellItemArray; fOkToBeSlow: boolean; out pCmdState: TEXPCMDSTATE): HResult; stdcall;
        function Invoke(psiItemArray: IShellItemArray; pbc: IBindCtx): HResult; stdcall;
        function GetFlags(out pFlags: TEXPCMDFLAGS): HResult; stdcall;
        function EnumSubCommands(out ppEnum: IEnumExplorerCommand): HResult; stdcall;
    end;

    PIExplorerCommand = ^IExplorerCommand;

    IExplorerCommandState = interface(IUnknown)
        ['{bddacb60-7657-47ae-8445-d23e1acf82ae}']
        function GetState(psiItemArray: IShellItemArray; fOkToBeSlow: boolean; out pCmdState: TEXPCMDSTATE): HResult; stdcall;
    end;

    IInitializeCommand = interface(IUnknown)
        ['{85075acf-231f-40ea-9610-d26b7b58f638}']
        function Initialize(pszCommandName: LPCWSTR; ppb: IPropertyBag): HResult; stdcall;
    end;


    IEnumExplorerCommand = interface(IUnknown)
        ['{a88826f8-186f-4987-aade-ea0cef8fbfe8}']
        function Next(celt: ULONG; out pUICommand: PIExplorerCommand; out pceltFetched: ULONG): HResult; stdcall;
        function Skip(celt: ULONG): HResult; stdcall;
        function Reset(): HResult; stdcall;
        function Clone(out ppenum: IEnumExplorerCommand): HResult; stdcall;
    end;


    IExplorerCommandProvider = interface(IUnknown)
        ['{64961751-0835-43c0-8ffe-d57686530e64}']
        function GetCommands(punkSite: IUnknown; const riid: TGUID; out ppv): HResult; stdcall;
        function GetCommand(const rguidCommandId: TGUID; const riid: TGUID; out ppv): HResult; stdcall;
    end;



    HTHEME = HANDLE;

    IInitializeNetworkFolder = interface(IUnknown)
        ['{6e0f9881-42a8-4f2a-97f8-8af4e026d92d}']
        function Initialize(pidl: PCIDLIST_ABSOLUTE; pidlTarget: PCIDLIST_ABSOLUTE; uDisplayType: UINT;
            pszResName: LPCWSTR; pszProvider: LPCWSTR): HResult; stdcall;
    end;


    TCPVIEW = (
        CPVIEW_CLASSIC = 0,
        CPVIEW_ALLITEMS = CPVIEW_CLASSIC,
        CPVIEW_CATEGORY = 1,
        CPVIEW_HOME = CPVIEW_CATEGORY
        );




    IOpenControlPanel = interface(IUnknown)
        ['{D11AD862-66DE-4DF4-BF6C-1F5621996AF1}']
        function Open(pszName: LPCWSTR; pszPage: LPCWSTR; punkSite: IUnknown): HResult; stdcall;
        function GetPath(pszName: LPCWSTR; pszPath: LPWSTR; cchPath: UINT): HResult; stdcall;
        function GetCurrentView(out pView: TCPVIEW): HResult; stdcall;
    end;




    IComputerInfoChangeNotify = interface(IUnknown)
        ['{0DF60D92-6818-46d6-B358-D66170DDE466}']
        function ComputerInfoChanged(): HResult; stdcall;
    end;


const
    STR_FILE_SYS_BIND_DATA: WideString = 'File System Bind Data';
    STR_FILE_SYS_BIND_DATA_WIN7_FORMAT: WideString = 'Win7FileSystemIdList';


type
    IFileSystemBindData = interface(IUnknown)
        ['{01E18D10-4D8B-11d2-855D-006008059367}']
        function SetFindData(const pfd: TWIN32_FIND_DATAW): HResult; stdcall;
        function GetFindData(out pfd: TWIN32_FIND_DATAW): HResult; stdcall;
    end;



    IFileSystemBindData2 = interface(IFileSystemBindData)
        ['{3acf075f-71db-4afa-81f0-3fc4fdf2a5b8}']
        function SetFileID(liFileID: LARGE_INTEGER): HResult; stdcall;
        function GetFileID(out pliFileID: LARGE_INTEGER): HResult; stdcall;
        function SetJunctionCLSID(const clsid: TCLSID): HResult; stdcall;
        function GetJunctionCLSID(out pclsid: TCLSID): HResult; stdcall;
    end;


{$IF  (NTDDI_VERSION >= NTDDI_WIN7)}
    TKNOWNDESTCATEGORY = (
        KDC_FREQUENT = 1,
        KDC_RECENT = (KDC_FREQUENT + 1)
        );


    ICustomDestinationList = interface(IUnknown)
        ['{6332debf-87b5-4670-90c0-5e57b408a49e}']
        function SetAppID(pszAppID: LPCWSTR): HResult; stdcall;
        function BeginList(out pcMinSlots: UINT; const riid: TGUID; out ppv): HResult; stdcall;
        function AppendCategory(pszCategory: LPCWSTR; poa: IObjectArray): HResult; stdcall;
        function AppendKnownCategory(category: TKNOWNDESTCATEGORY): HResult; stdcall;
        function AddUserTasks(poa: IObjectArray): HResult; stdcall;
        function CommitList(): HResult; stdcall;
        function GetRemovedDestinations(const riid: TGUID; out ppv): HResult; stdcall;
        function DeleteList(pszAppID: LPCWSTR): HResult; stdcall;
        function AbortList(): HResult; stdcall;
    end;


    IApplicationDestinations = interface(IUnknown)
        ['{12337d35-94c6-48a0-bce7-6a9c69d4d600}']
        function SetAppID(pszAppID: LPCWSTR): HResult; stdcall;
        function RemoveDestination(punk: IUnknown): HResult; stdcall;
        function RemoveAllDestinations(): HResult; stdcall;
    end;



    TAPPDOCLISTTYPE = (
        ADLT_RECENT = 0,
        ADLT_FREQUENT = (ADLT_RECENT + 1)
        );


    IApplicationDocumentLists = interface(IUnknown)
        ['{3c594f9f-9f30-47a1-979a-c9e83d3d0a06}']
        function SetAppID(pszAppID: LPCWSTR): HResult; stdcall;
        function GetList(listtype: TAPPDOCLISTTYPE; cItemsDesired: UINT; const riid: TGUID; out ppv): HResult; stdcall;
    end;



    IObjectWithAppUserModelID = interface(IUnknown)
        ['{36db0196-9665-46d1-9ba7-d3709eecf9ed}']
        function SetAppID(pszAppID: LPCWSTR): HResult; stdcall;
        function GetAppID(out ppszAppID: LPWSTR): HResult; stdcall;
    end;


    IObjectWithProgID = interface(IUnknown)
        ['{71e806fb-8dee-46fc-bf8c-7748a8a1ae13}']
        function SetProgID(pszProgID: LPCWSTR): HResult; stdcall;
        function GetProgID(out ppszProgID: LPWSTR): HResult; stdcall;
    end;


    IUpdateIDList = interface(IUnknown)
        ['{6589b6d2-5f8d-4b9e-b7e0-23cdd9717d8c}']
        function Update(pbc: IBindCtx; pidlIn: PCUITEMID_CHILD; out ppidlOut: PITEMID_CHILD): HResult; stdcall;
    end;



function SetCurrentProcessExplicitAppUserModelID(AppID: PCWSTR): HResult; stdcall; external shell32_dll;
function GetCurrentProcessExplicitAppUserModelID(out AppID: PWSTR): HResult; stdcall; external shell32_dll;
{$ENDIF}// NTDDI_WIN7

type
    IDesktopGadget = interface(IUnknown)
        ['{c1646bc4-f298-4f91-a204-eb2dd1709d1a}']
        function RunGadget(gadgetPath: LPCWSTR): HResult; stdcall;
    end;


{$IF  (NTDDI_VERSION >= NTDDI_WIN8)}
    TDESKTOP_SLIDESHOW_OPTIONS = (
        DSO_SHUFFLEIMAGES = $1
        );


    TDESKTOP_SLIDESHOW_STATE = (
        DSS_ENABLED = $1,
        DSS_SLIDESHOW = $2,
        DSS_DISABLED_BY_REMOTE_SESSION = $4
        );


    TDESKTOP_SLIDESHOW_DIRECTION = (
        DSD_FORWARD = 0,
        DSD_BACKWARD = 1
        );

    TDESKTOP_WALLPAPER_POSITION = (
        DWPOS_CENTER = 0,
        DWPOS_TILE = 1,
        DWPOS_STRETCH = 2,
        DWPOS_FIT = 3,
        DWPOS_FILL = 4,
        DWPOS_SPAN = 5
        );


    IDesktopWallpaper = interface(IUnknown)
        ['{B92B56A9-8B55-4E14-9A89-0199BBB6F93B}']
        function SetWallpaper(monitorID: LPCWSTR; wallpaper: LPCWSTR): HResult; stdcall;
        function GetWallpaper(monitorID: LPCWSTR; out wallpaper: LPWSTR): HResult; stdcall;
        function GetMonitorDevicePathAt(monitorIndex: UINT; out monitorID: LPWSTR): HResult; stdcall;
        function GetMonitorDevicePathCount(out Count: UINT): HResult; stdcall;
        function GetMonitorRECT(monitorID: LPCWSTR; out displayRect: TRECT): HResult; stdcall;
        function SetBackgroundColor(color: TCOLORREF): HResult; stdcall;
        function GetBackgroundColor(out color: TCOLORREF): HResult; stdcall;
        function SetPosition(position: TDESKTOP_WALLPAPER_POSITION): HResult; stdcall;
        function GetPosition(out position: TDESKTOP_WALLPAPER_POSITION): HResult; stdcall;
        function SetSlideshow(items: IShellItemArray): HResult; stdcall;
        function GetSlideshow(out items: IShellItemArray): HResult; stdcall;
        function SetSlideshowOptions(options: TDESKTOP_SLIDESHOW_OPTIONS; slideshowTick: UINT): HResult; stdcall;
        function GetSlideshowOptions(out options: TDESKTOP_SLIDESHOW_OPTIONS; out slideshowTick: UINT): HResult; stdcall;
        function AdvanceSlideshow(monitorID: LPCWSTR; direction: TDESKTOP_SLIDESHOW_DIRECTION): HResult; stdcall;
        function GetStatus(out state: TDESKTOP_SLIDESHOW_STATE): HResult; stdcall;
        function Enable(enable: boolean): HResult; stdcall;
    end;

{$ENDIF}// NTDDI_WIN8



const
    HOMEGROUP_SECURITY_GROUP_MULTI: WideString = 'HUG';
    HOMEGROUP_SECURITY_GROUP: WideString = 'HomeUsers';



type
    THOMEGROUPSHARINGCHOICES = (
        HGSC_NONE = 0,
        HGSC_MUSICLIBRARY = $1,
        HGSC_PICTURESLIBRARY = $2,
        HGSC_VIDEOSLIBRARY = $4,
        HGSC_DOCUMENTSLIBRARY = $8,
        HGSC_PRINTERS = $10
        );
    PHOMEGROUPSHARINGCHOICES = ^THOMEGROUPSHARINGCHOICES;



    IHomeGroup = interface(IUnknown)
        ['{7a3bd1d9-35a9-4fb3-a467-f48cac35e2d0}']
        function IsMember(member: boolean): HResult; stdcall;
        function ShowSharingWizard(owner: HWND; sharingchoices: PHOMEGROUPSHARINGCHOICES): HResult; stdcall;
    end;



    IInitializeWithPropertyStore = interface(IUnknown)
        ['{C3E12EB5-7D8D-44f8-B6DD-0E77B34D6DE4}']
        function Initialize(pps: IPropertyStore): HResult; stdcall;
    end;




    IOpenSearchSource = interface(IUnknown)
        ['{F0EE7333-E6FC-479b-9F25-A860C234A38E}']
        function GetResults(hwnd: HWND; pszQuery: LPCWSTR; dwStartIndex: DWORD; dwCount: DWORD; const riid: TGUID;
            out ppv): HResult; stdcall;
    end;



    TLIBRARYFOLDERFILTER = (
        LFF_FORCEFILESYSTEM = 1,
        LFF_STORAGEITEMS = 2,
        LFF_ALLITEMS = 3
        );

    TLIBRARYOPTIONFLAGS = (
        LOF_DEFAULT = 0,
        LOF_PINNEDTONAVPANE = $1,
        LOF_MASK_ALL = $1
        );


    TDEFAULTSAVEFOLDERTYPE = (
        DSFT_DETECT = 1,
        DSFT_PRIVATE = (DSFT_DETECT + 1),
        DSFT_PUBLIC = (DSFT_PRIVATE + 1)
        );

    TLIBRARYSAVEFLAGS = (
        LSF_FAILIFTHERE = 0,
        LSF_OVERRIDEEXISTING = $1,
        LSF_MAKEUNIQUENAME = $2
        );




    IShellLibrary = interface(IUnknown)
        ['{11a66efa-382e-451a-9234-1e0e12ef3085}']
        function LoadLibraryFromItem(psiLibrary: IShellItem; grfMode: DWORD): HResult; stdcall;
        function LoadLibraryFromKnownFolder(const kfidLibrary: TKNOWNFOLDERID; grfMode: DWORD): HResult; stdcall;
        function AddFolder(psiLocation: IShellItem): HResult; stdcall;
        function RemoveFolder(psiLocation: IShellItem): HResult; stdcall;
        function GetFolders(lff: TLIBRARYFOLDERFILTER; const riid: TGUID; out ppv): HResult; stdcall;
        function ResolveFolder(psiFolderToResolve: IShellItem; dwTimeout: DWORD; const riid: TGUID; out ppv): HResult; stdcall;
        function GetDefaultSaveFolder(dsft: TDEFAULTSAVEFOLDERTYPE; const riid: TGUID; out ppv): HResult; stdcall;
        function SetDefaultSaveFolder(dsft: TDEFAULTSAVEFOLDERTYPE; psi: IShellItem): HResult; stdcall;
        function GetOptions(out plofOptions: TLIBRARYOPTIONFLAGS): HResult; stdcall;
        function SetOptions(lofMask: TLIBRARYOPTIONFLAGS; lofOptions: TLIBRARYOPTIONFLAGS): HResult; stdcall;
        function GetFolderType(out pftid: TFOLDERTYPEID): HResult; stdcall;
        function SetFolderType(const ftid: TFOLDERTYPEID): HResult; stdcall;
        function GetIcon(out ppszIcon: LPWSTR): HResult; stdcall;
        function SetIcon(pszIcon: LPCWSTR): HResult; stdcall;
        function Commit(): HResult; stdcall;
        function Save(psiFolderToSaveIn: IShellItem; pszLibraryName: LPCWSTR; lsf: TLIBRARYSAVEFLAGS;
            out ppsiSavedTo: IShellItem): HResult; stdcall;
        function SaveInKnownFolder(const kfidToSaveIn: TKNOWNFOLDERID; pszLibraryName: LPCWSTR; lsf: TLIBRARYSAVEFLAGS;
            out ppsiSavedTo: IShellItem): HResult; stdcall;
    end;


    TDEFAULT_FOLDER_MENU_RESTRICTIONS = (
        DFMR_DEFAULT = 0,
        DFMR_NO_STATIC_VERBS = $8,
        DFMR_STATIC_VERBS_ONLY = $10,
        DFMR_NO_RESOURCE_VERBS = $20,
        DFMR_OPTIN_HANDLERS_ONLY = $40,
        DFMR_RESOURCE_AND_FOLDER_VERBS_ONLY = $80,
        DFMR_USE_SPECIFIED_HANDLERS = $100,
        DFMR_USE_SPECIFIED_VERBS = $200,
        DFMR_NO_ASYNC_VERBS = $400
        );
    PDEFAULT_FOLDER_MENU_RESTRICTIONS = ^TDEFAULT_FOLDER_MENU_RESTRICTIONS;



    IDefaultFolderMenuInitialize = interface(IUnknown)
        ['{7690aa79-f8fc-4615-a327-36f7d18f5d91}']
        function Initialize(hwnd: HWND; pcmcb: IContextMenuCB; pidlFolder: PCIDLIST_ABSOLUTE; psf: IShellFolder;
            cidl: UINT; apidl: PCUITEMID_CHILD_ARRAY; punkAssociation: IUnknown; cKeys: UINT; const aKeys: HKEY): HResult; stdcall;
        function SetMenuRestrictions(dfmrValues: TDEFAULT_FOLDER_MENU_RESTRICTIONS): HResult; stdcall;
        function GetMenuRestrictions(dfmrMask: TDEFAULT_FOLDER_MENU_RESTRICTIONS;
            pdfmrValues: PDEFAULT_FOLDER_MENU_RESTRICTIONS): HResult; stdcall;
        function SetHandlerClsid(const rclsid: TCLSID): HResult; stdcall;
    end;



{$IF  (NTDDI_VERSION >= NTDDI_WIN8)}
    TACTIVATEOPTIONS = (
        AO_NONE = 0,
        AO_DESIGNMODE = $1,
        AO_NOERRORUI = $2,
        AO_NOSPLASHSCREEN = $4,
        AO_PRELAUNCH = $2000000
        );

    IApplicationActivationManager = interface(IUnknown)
        ['{2e941141-7f97-4756-ba1d-9decde894a3d}']
        function ActivateApplication(appUserModelId: LPCWSTR; arguments: LPCWSTR; options: TACTIVATEOPTIONS;
            out processId: DWORD): HResult; stdcall;
        function ActivateForFile(appUserModelId: LPCWSTR; itemArray: IShellItemArray; verb: LPCWSTR;
            out processId: DWORD): HResult; stdcall;
        function ActivateForProtocol(appUserModelId: LPCWSTR; itemArray: IShellItemArray; out processId: DWORD): HResult; stdcall;
    end;

{$ENDIF}// NTDDI_WIN8

{$IF (NTDDI_VERSION >= NTDDI_WINTHRESHOLD)}
    IVirtualDesktopManager = interface(IUnknown)
        ['{a5cd92ff-29be-454c-8d04-d82879fb3f1b}']
        function IsWindowOnCurrentVirtualDesktop(topLevelWindow: HWND; out onCurrentDesktop: boolean): HResult; stdcall;
        function GetWindowDesktopId(topLevelWindow: HWND; out desktopId: TGUID): HResult; stdcall;
        function MoveWindowToDesktop(topLevelWindow: HWND; const desktopId: TGUID): HResult; stdcall;
    end;

{$ENDIF}// NTDDI_WINTHRESHOLD


{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
function SHGetTemporaryPropertyForItem(psi: IShellItem; const propkey: TPROPERTYKEY; out ppropvar: TPROPVARIANT): HResult;
    stdcall; external shell32_dll;
function SHSetTemporaryPropertyForItem(psi: IShellItem; const propkey: TPROPERTYKEY; const propvar: TPROPVARIANT): HResult;
    stdcall; external shell32_dll;
{$ENDIF}// NTDDI_VISTA



{$IF  (NTDDI_VERSION >= NTDDI_WIN7)}
{$IF  (_WIN32_IE >= _WIN32_IE_IE70)}
type
    TLIBRARYMANAGEDIALOGOPTIONS = (
        LMD_DEFAULT = 0,
        LMD_ALLOWUNINDEXABLENETWORKLOCATIONS = $1
        );

function SHShowManageLibraryUI(psiLibrary: IShellItem; hwndOwner: HWND; pszTitle: LPCWSTR; pszInstruction: LPCWSTR;
    lmdOptions: TLIBRARYMANAGEDIALOGOPTIONS): HResult; stdcall; external shell32_dll;
function SHResolveLibrary(psiLibrary: IShellItem): HResult; stdcall; external shell32_dll;

// These functions properly initialize their  out  parameters to NULL, and only return NULL
// on failure, but /analyze can't presently distinguish the failure case from the success case, and
// throws warning C6387 anyway.  Thus, the warning is disabled to avoid generating noise for code
// that includes shobjidl.h and compiles with /analyze.

function SHCreateLibrary(const riid: TGUID; out ppv): HRESULT;
function SHLoadLibraryFromItem(psiLibrary: IShellItem; grfMode: DWORD; const riid: TGUID; out ppv): HRESULT;
{$ENDIF}// _WIN32_IE >= _WIN32_IE_IE70
{$ENDIF}// NTDDI_WIN7

{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
type
    IAssocHandlerInvoker = interface(IUnknown)
        ['{92218CAB-ECAA-4335-8133-807FD234C2EE}']
        function SupportsSelection(): HResult; stdcall;
        function Invoke(): HResult; stdcall;
    end;


    IAssocHandler = interface(IUnknown)
        ['{F04061AC-1659-4a3f-A954-775AA57FC083}']
        function GetName(out ppsz: LPWSTR): HResult; stdcall;
        function GetUIName(out ppsz: LPWSTR): HResult; stdcall;
        function GetIconLocation(out ppszPath: LPWSTR; out pIndex: int32): HResult; stdcall;
        function IsRecommended(): HResult; stdcall;
        function MakeDefault(pszDescription: LPCWSTR): HResult; stdcall;
        function Invoke(pdo: IDataObject): HResult; stdcall;
        function CreateInvoker(pdo: IDataObject; out ppInvoker: IAssocHandlerInvoker): HResult; stdcall;
    end;

    PIAssocHandler = ^IAssocHandler;

    IEnumAssocHandlers = interface(IUnknown)
        ['{973810ae-9599-4b88-9e4d-6ee98c9552da}']
        function Next(celt: ULONG; out rgelt: PIAssocHandler; out pceltFetched: ULONG): HResult; stdcall;
    end;

    TASSOC_FILTER = (
        ASSOC_FILTER_NONE = 0,
        ASSOC_FILTER_RECOMMENDED = $1
        );


function SHAssocEnumHandlers(pszExtra: PCWSTR; afFilter: TASSOC_FILTER; out ppEnumHandler: IEnumAssocHandlers): HResult;
    stdcall; external Shell32_Dll;
{$ENDIF}// NTDDI_VISTA


 {$IF  (NTDDI_VERSION >= NTDDI_WIN7)}
function SHAssocEnumHandlersForProtocolByApplication(protocol: PCWSTR; const riid: TGUID; out enumHandlers): HResult;
    stdcall; external Shell32_Dll;
{$ENDIF}// NTDDI_WIN7



{$IF  (NTDDI_VERSION >= NTDDI_WIN8)}
type
    IDataObjectProvider = interface(IUnknown)
        ['{3D25F6D6-4B2A-433c-9184-7C33AD35D001}']
        function GetDataObject(out dataObject: IDataObject): HResult; stdcall;
        function SetDataObject(dataObject: IDataObject): HResult; stdcall;
    end;


    IDataTransferManagerInterop = interface(IUnknown)
        ['{3A3DCD6C-3EAB-43DC-BCDE-45671CE800C8}']
        function GetForWindow(appWindow: HWND; const riid: TGUID; out dataTransferManager): HResult; stdcall;
        function ShowShareUIForWindow(appWindow: HWND): HResult; stdcall;
    end;

{$ENDIF}// NTDDI_WIN8


  {$IF  (NTDDI_VERSION >= NTDDI_WIN8)}
    IFrameworkInputPaneHandler = interface(IUnknown)
        ['{226C537B-1E76-4D9E-A760-33DB29922F18}']
        function Showing(prcInputPaneScreenLocation: PRECT; fEnsureFocusedElementInView: boolean): HResult; stdcall;
        function Hiding(fEnsureFocusedElementInView: boolean): HResult; stdcall;
    end;


    IFrameworkInputPane = interface(IUnknown)
        ['{5752238B-24F0-495A-82F1-2FD593056796}']
        function Advise(pWindow: IUnknown; pHandler: IFrameworkInputPaneHandler; out pdwCookie: DWORD): HResult; stdcall;
        function AdviseWithHWND(hwnd: HWND; pHandler: IFrameworkInputPaneHandler; out pdwCookie: DWORD): HResult; stdcall;
        function Unadvise(dwCookie: DWORD): HResult; stdcall;
        function Location(out prcInputPaneScreenLocation: TRECT): HResult; stdcall;
    end;


const
    PROP_CONTRACT_DELEGATE: WideString = 'ContractDelegate';


// For applications that use modern APIs and use a child or owned window
// that run on different threads this API must be used to indicate which
// window is the current main window. Call this API when those windows change their state.

procedure SetContractDelegateWindow(hwndSource: HWND; hwndDelegate: HWND);

{$ENDIF}// NTDDI_WIN8


{$IF  (NTDDI_VERSION >= NTDDI_WIN8)}
type
    TUNDOCK_REASON = (
        UR_RESOLUTION_CHANGE = 0,
        UR_MONITOR_DISCONNECT = 1
        );


    IAccessibilityDockingServiceCallback = interface(IUnknown)
        ['{157733FD-A592-42E5-B594-248468C5A81B}']
        function Undocked(undockReason: TUNDOCK_REASON): HResult; stdcall;
    end;


    IAccessibilityDockingService = interface(IUnknown)
        ['{8849DC22-CEDF-4C95-998D-051419DD3F76}']
        function GetAvailableSize(hMonitor: HMONITOR; out pcxFixed: UINT; out pcyMax: UINT): HResult; stdcall;
        function DockWindow(hwnd: HWND; hMonitor: HMONITOR; cyRequested: UINT;
            pCallback: IAccessibilityDockingServiceCallback): HResult; stdcall;
        function UndockWindow(hwnd: HWND): HResult; stdcall;
    end;


    TMONITOR_APP_VISIBILITY = (
        MAV_UNKNOWN = 0,
        MAV_NO_APP_VISIBLE = 1,
        MAV_APP_VISIBLE = 2
        );


    IAppVisibilityEvents = interface(IUnknown)
        ['{6584CE6B-7D82-49C2-89C9-C6BC02BA8C38}']
        function AppVisibilityOnMonitorChanged(hMonitor: HMONITOR; previousMode: TMONITOR_APP_VISIBILITY;
            currentMode: TMONITOR_APP_VISIBILITY): HResult; stdcall;
        function LauncherVisibilityChange(currentVisibleState: boolean): HResult; stdcall;
    end;



    IAppVisibility = interface(IUnknown)
        ['{2246EA2D-CAEA-4444-A3C4-6DE827E44313}']
        function GetAppVisibilityOnMonitor(hMonitor: HMONITOR; out pMode: TMONITOR_APP_VISIBILITY): HResult; stdcall;
        function IsLauncherVisible(out pfVisible: boolean): HResult; stdcall;
        function Advise(pCallback: IAppVisibilityEvents; out pdwCookie: DWORD): HResult; stdcall;
        function Unadvise(dwCookie: DWORD): HResult; stdcall;
    end;


    PZZWSTR = PWCHAR;


    IPackageDebugSettings = interface(IUnknown)
        ['{F27C3930-8029-4AD1-94E3-3DBA417810C1}']
        function EnableDebugging(packageFullName: LPCWSTR; debuggerCommandLine: LPCWSTR; environment: PZZWSTR): HResult; stdcall;
        function DisableDebugging(packageFullName: LPCWSTR): HResult; stdcall;
        function Suspend(packageFullName: LPCWSTR): HResult; stdcall;
        function Resume(packageFullName: LPCWSTR): HResult; stdcall;
        function TerminateAllProcesses(packageFullName: LPCWSTR): HResult; stdcall;
        function SetTargetSessionId(sessionId: ULONG): HResult; stdcall;
        function EnumerateBackgroundTasks(packageFullName: LPCWSTR; out taskCount: ULONG; out taskIds: PCGUID;
            out taskNames: LPCWSTR): HResult; stdcall;
        function ActivateBackgroundTask(taskId: PCGUID): HResult; stdcall;
        function StartServicing(packageFullName: LPCWSTR): HResult; stdcall;
        function StopServicing(packageFullName: LPCWSTR): HResult; stdcall;
        function StartSessionRedirection(packageFullName: LPCWSTR; sessionId: ULONG): HResult; stdcall;
        function StopSessionRedirection(packageFullName: LPCWSTR): HResult; stdcall;
        function GetPackageExecutionState(packageFullName: LPCWSTR; out packageExecutionState: TPACKAGE_EXECUTION_STATE): HResult;
            stdcall;
        function RegisterForPackageStateChanges(packageFullName: LPCWSTR;
            pPackageExecutionStateChangeNotification: IPackageExecutionStateChangeNotification; out pdwCookie: DWORD): HResult; stdcall;
        function UnregisterForPackageStateChanges(dwCookie: DWORD): HResult; stdcall;
    end;



    IPackageDebugSettings2 = interface(IPackageDebugSettings)
        ['{6E3194BB-AB82-4D22-93F5-FABDA40E7B16}']
        function EnumerateApps(packageFullName: LPCWSTR; out appCount: ULONG; out appUserModelIds: LPWSTR;
            out appDisplayNames: LPWSTR): HResult; stdcall;
    end;



    ISuspensionDependencyManager = interface(IUnknown)
        ['{52B83A42-2543-416A-81D9-C0DE7969C8B3}']
        function RegisterAsChild(processHandle: HANDLE): HResult; stdcall;
        function GroupChildWithParent(childProcessHandle: HANDLE): HResult; stdcall;
        function UngroupChildFromParent(childProcessHandle: HANDLE): HResult; stdcall;
    end;



    TAHE_TYPE = (
        AHE_DESKTOP = 0,
        AHE_IMMERSIVE = 1
        );



    IExecuteCommandApplicationHostEnvironment = interface(IUnknown)
        ['{18B21AA9-E184-4FF0-9F5E-F882D03771B3}']
        function GetValue(out pahe: TAHE_TYPE): HResult; stdcall;
    end;


    TEC_HOST_UI_MODE = (
        ECHUIM_DESKTOP = 0,
        ECHUIM_IMMERSIVE = (ECHUIM_DESKTOP + 1),
        ECHUIM_SYSTEM_LAUNCHER = (ECHUIM_IMMERSIVE + 1)
        );


    IExecuteCommandHost = interface(IUnknown)
        ['{4b6832a2-5f04-4c9d-b89d-727a15d103e7}']
        function GetUIMode(out pUIMode: TEC_HOST_UI_MODE): HResult; stdcall;
    end;




{$IF  (NTDDI_VERSION >= NTDDI_WINBLUE)}

const
    STR_TAB_REUSE_IDENTIFIER: WideString = 'Tab Reuse Identifier';
    STR_REFERRER_IDENTIFIER: WideString = 'Referrer Identifier';

type
    ILaunchTargetMonitor = interface(IUnknown)
        ['{266FBC7E-490D-46ED-A96B-2274DB252003}']
        function GetMonitor(out monitor: HMONITOR): HResult; stdcall;
    end;



    ILaunchSourceViewSizePreference = interface(IUnknown)
        ['{E5AA01F7-1FB8-4830-8720-4E6734CBD5F3}']
        function GetSourceViewToPosition(out hwnd: HWND): HResult; stdcall;
        function GetSourceViewSizePreference(out sourceSizeAfterLaunch: TAPPLICATION_VIEW_SIZE_PREFERENCE): HResult; stdcall;
    end;



    ILaunchTargetViewSizePreference = interface(IUnknown)
        ['{2F0666C6-12F7-4360-B511-A394A0553725}']
        function GetTargetViewSizePreference(out targetSizeOnLaunch: TAPPLICATION_VIEW_SIZE_PREFERENCE): HResult; stdcall;
    end;



    ILaunchSourceAppUserModelId = interface(IUnknown)
        ['{989191AC-28FF-4CF0-9584-E0D078BC2396}']
        function GetAppUserModelId(out launchingApp: LPWSTR): HResult; stdcall;
    end;


{$ENDIF}// NTDDI_WINBLUE


    IHandlerInfo = interface(IUnknown)
        ['{997706ef-f880-453b-8118-39e1a2d2655a}']
        function GetApplicationDisplayName(out Value: LPWSTR): HResult; stdcall;
        function GetApplicationPublisher(out Value: LPWSTR): HResult; stdcall;
        function GetApplicationIconReference(out Value: LPWSTR): HResult; stdcall;
    end;


    IHandlerActivationHost = interface(IUnknown)
        ['{35094a87-8bb1-4237-96c6-c417eebdb078}']
        function BeforeCoCreateInstance(const clsidHandler: TCLSID; itemsBeingActivated: IShellItemArray;
            handlerInfo: IHandlerInfo): HResult; stdcall;
        function BeforeCreateProcess(applicationPath: LPCWSTR; commandLine: LPCWSTR; handlerInfo: IHandlerInfo): HResult; stdcall;
    end;



{$IF  (NTDDI_VERSION >= NTDDI_WIN10)}
    IAppActivationUIInfo = interface(IUnknown)
        ['{abad189d-9fa3-4278-b3ca-8ca448a88dcb}']
        function GetMonitor(out Value: HMONITOR): HResult; stdcall;
        function GetInvokePoint(out Value: TPOINT): HResult; stdcall;
        function GetShowCommand(out Value: int32): HResult; stdcall;
        function GetShowUI(out Value: boolean): HResult; stdcall;
        function GetKeyState(out Value: DWORD): HResult; stdcall;
    end;


{$ENDIF}// NTDDI_WIN10

{$ENDIF}// NTDDI_WIN8


{$IF  (NTDDI_VERSION >= NTDDI_WINBLUE)}
    IContactManagerInterop = interface(IUnknown)
        ['{99eacba7-e073-43b6-a896-55afe48a0833}']
        function ShowContactCardForWindow(appWindow: HWND; contact: IUnknown; const selection: TRECT;
            preferredPlacement: TFLYOUT_PLACEMENT): HResult; stdcall;
    end;

{$ENDIF}// NTDDI_WINBLUE



{$IF  (_WIN32_IE >= _WIN32_IE_IE70)}
function SHRemovePersonalPropertyValues(psia: IShellItemArray): HResult; stdcall; external shell32_dll;
function SHAddDefaultPropertiesByExt(pszExt: PCWSTR; pPropStore: IPropertyStore): HResult; stdcall; external shell32_dll;
function SHCreateDefaultPropertiesOp(psi: IShellItem; out ppFileOp: IFileOperation): HResult; stdcall; external shell32_dll;
function SHSetDefaultProperties(hwnd: HWND; psi: IShellItem; dwFileOpFlags: DWORD; pfops: IFileOperationProgressSink): HResult;
    stdcall; external shell32_dll;
{$ENDIF}// (_WIN32_IE >= _WIN32_IE_IE70)


{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
function SHCreateAssociationRegistration(const riid: TGUID; out ppv): HResult; stdcall; external Shell32_dll;
{$ENDIF}// NTDDI_VISTA


implementation

uses
    ActiveX;



procedure FreeKnownFolderDefinitionFields(var pKFD: TKNOWNFOLDER_DEFINITION); inline;
begin
    CoTaskMemFree(pKFD.pszName);
    CoTaskMemFree(pKFD.pszDescription);
    CoTaskMemFree(pKFD.pszRelativePath);
    CoTaskMemFree(pKFD.pszParsingName);
    CoTaskMemFree(pKFD.pszTooltip);
    CoTaskMemFree(pKFD.pszLocalizedName);
    CoTaskMemFree(pKFD.pszIcon);
    CoTaskMemFree(pKFD.pszSecurity);
end;



function SHCreateLibrary(const riid: TGUID; out ppv): HRESULT; inline;
begin
    Result := CoCreateInstance(CLSID_ShellLibrary, nil, CLSCTX_INPROC_SERVER, riid, ppv);
end;



function SHLoadLibraryFromItem(psiLibrary: IShellItem; grfMode: DWORD; const riid: TGUID; out ppv): HRESULT; inline;
var
    hr: HResult;
    plib: IShellLibrary;
begin
    //    ppv := nil;

{    hr := CoCreateInstance(CLSID_ShellLibrary,nil, 0, CLSCTX_INPROC_SERVER, plib);
    if (SUCCEEDED(hr)) then
    begin
        hr := plib.LoadLibraryFromItem(psiLibrary, grfMode);
        if (SUCCEEDED(hr)) then
        begin
            hr := plib.QueryInterface(riid, ppv);
        end;
        plib := nil;
    end;
    Result := hr;   }
end;



procedure SetContractDelegateWindow(hwndSource: HWND; hwndDelegate: HWND); inline;
begin
    if (hwndDelegate <> 0) then
    begin
        SetPropW(hwndSource, pWideChar(PROP_CONTRACT_DELEGATE), hwndDelegate);
    end
    else
    begin
        RemovePropW(hwndSource, pWideChar(PROP_CONTRACT_DELEGATE));
    end;
end;

end.
