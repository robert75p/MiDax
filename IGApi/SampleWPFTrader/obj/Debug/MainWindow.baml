   M S B A M L   `   `   `  ����J  FSampleWPFTrader, Version=1.5.1.0, Culture=neutral, PublicKeyToken=nullE'clr-namespace:SampleWPFTrader.ViewModelSampleWPFTrader.ViewModel  5   	   G(clr-namespace:SampleWPFTrader.ConvertersSampleWPFTrader.Converters  5   	   d `GalaSoft.MvvmLight.Extras, Version=5.0.0.24261, Culture=neutral, PublicKeyToken=669f0b5e8f868abfjKclr-namespace:GalaSoft.MvvmLight.Command;assembly=GalaSoft.MvvmLight.ExtrasGalaSoft.MvvmLight.Command 5   	   c _System.Windows.Interactivity, Version=4.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35qPclr-namespace:System.Windows.Interactivity;assembly=System.Windows.InteractivitySystem.Windows.Interactivity 5   	        SampleWPFTrader.MainWindow   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   =	viewModel'clr-namespace:SampleWPFTrader.ViewModel     5   	   :xctk)http://schemas.xceed.com/wpf/xaml/toolkit     5   	   ?
Converters(clr-namespace:SampleWPFTrader.Converters     5   	   _commandKclr-namespace:GalaSoft.MvvmLight.Command;assembly=GalaSoft.MvvmLight.Extras     5   	   ^iPclr-namespace:System.Windows.Interactivity;assembly=System.Windows.Interactivity     5   	     � Title$  IG WPF Trader version 0.5��5
   	   $	��800��6+   $
��1280��68    � 	Resources 5      4   .SampleWPFTrader.ViewModel.ApplicationViewModel   avm2   ,SampleWPFTrader.ViewModel.PositionsViewModel  pvm3   -SampleWPFTrader.ViewModel.WatchlistsViewModel  wvm/   )SampleWPFTrader.ViewModel.OrdersViewModel  ovm/   )SampleWPFTrader.ViewModel.BrowseViewModel  bvm��%�   &	        &	      &	 &     &	 9     &	 L       5   
   6)     5   
   6'     5   
   6(     5   
   6$     5   
   6$   5      .��5      � $��Stretch=�6   $��Stretch=�6'    � DataContext 6E   ��  �� Source# [   5   
   1   +SampleWPFTrader.Converters.BoolToVisibility  	boolToVis��%   &	         5      6*   5      ��5   
   �� 5       j� Stretch$
 Fill=�6    �� ImageSource$ Resources\Background.jpg��6)   6R   .+�5   
   � $��0,0,0,0q�6    � RowDefinitions 5      �� 5      �� 5       .+�5#      �� $��0��6   $��	20,20,0,0q�6&   $
��Left=�69   $	��Top=�6T   $��Stretch=�6l   $	��700��6�   $
��1240��6�   $��2��6�   z�5$      V� 5%      .~�5&      �� �� 5'       �� AngleY$ 0.048Q�6(   �� 5(      T� 5)       T� Y$ 0.499Q�6-   5*      .@�5-      �� $
��Home��6    6(   �� # [  	 �� 
IsSelected	 6\   �� 
 �� Path$
 LoginTabSelected�.��5.      � -   5         �Name$ LoginPanel2��5.       50      �� 51      $	��150 �6,   6;   �� 52      $	��150 �6,   6;   �� 53   	   $	��150 �6   6&   �� 54   	   $	��150 �6   6&   �� 55   	   $��40 �6   6%   .+�58      ]� $��0��6$   $��	20,0,20,0q�61   .+�59      &   System.Windows.Controls.DataGrid  $	��Top=�6'      AutoGenerateColumns .  $��10q�6�   ��6?   �� $
 Accounts�   Columns 5:   "   0  *System.Windows.Controls.DataGridTextColumn  5;   &   ,	  &System.Windows.Controls.DataGridColumn 	  Header$ account name��69   1
  +System.Windows.Controls.DataGridBoundColumn 
  Binding 6O   �� $
 AccountName�  5<   &   $ account type��69    6O   �� $
 AccountType�  5=   &   $ 
amount due��69    6M   �� $
 	AmountDue�  5>   &   $ available cash��69    6Q   �� $
 AvailableCash�  5?   &   $ deposit��69    6J   �� $
 Deposit�  5@   &   $ ls endpoint��69    6N   �� $
 
LsEndpoint�  5A   &   $ 
profitloss��69    6M   �� $
 
ProfitLoss�  5B   &   $ used margin��69    6N   �� $
 
UsedMargin�  5C   &   $ 
account id��69    6M   �� $
 	AccountId�  5D      $ balance��6    6/   �� $
 Balance�5F      5H      ]� 5J      $��1��6$   $��	20,0,20,0q�61   .+�5K        $	��Top=�6'    .  $��10q�6�   ��6?   �� $
 TradeSubscriptions� 5L   "     5M   &   $ 
Trade Type��69    6M   �� $
 	TradeType�  5N   &   $
 epic��69    6G   �� $

 Epic�  5O   &   $ 	Item Name��69    6L   �� $
 ItemName�  5P   &   $ dealId��69    6I   �� $
 DealId�  5Q   &   $ dealReference��69    6P   �� $
 DealReference�  5R   &   $ deal status��69    6N   �� $
 
DealStatus�  5S   &   $ 	direction��69    6L   �� $
 	Direction�  5T   &   $ expiry��69    6I   �� $
 Expiry�  5U   &   $ guaranteed stop��69    6R   �� $
 GuaranteedStop�  5V   &   $ level��69    6H   �� $
 Level�  5W   &   $ limit level��69    6N   �� $
 
Limitlevel�  5X   &   $
 size��69    6G   �� $

 Size�  5Y   &   $ status��69    6I   �� $
 Status�  5Z      $ 
stop level��6    62   �� $
 	StopLevel�5\      5^      ]� 5`      $��2��6   $��	20,0,20,0q�6   .+�5a   	     $	��Top=�6    .  $��10q�6q   ��6*   �� $
 AffectedDeals� 5b   
     5c      $ affected deal id��6    68   �� $
 AffectedDeal_Id�  5d      $ affected deal status��6    6<   �� $
 AffectedDeal_Status�5f   
   5g   	   �� 5i      -   5         ��Name$ CustomerDebugDataTextBox��5i      
�������
���   �
���2͚�$��2q�6w   $��3��6�   $��	30,0,30,0q�6�   " �� VerticalScrollBarVisibility$ Visible=�6�   $	��100��6   6�   �� # [  ��6  �� *ApplicationDebugData+�� 5k      -   5         ��Name$ btnExit��5k   !   $
��Exit��62   $��Center=�6A   $��23��6^   $��4��6k   $��Center=�6x   $��73��6�   ��6�   �� *ExitCommand+5m      5n      �� 5o      -   5         ��Name$ PositionsTab��5o      $��	Positions��60    6C   �� # [ 	 6w   �� $
 PositionsTabSelected�.��5p      �  5q      �� 5r      $	��300 �6,   �� 5s      $	��300 �6,   .+�5v        $��0��6#   $	��Top=�60    .  $��20q�6�   ��6H   �� $
 	Positions� 6�   �� # [  5w        5x   "   $
 name��65    6C   �� $
 Model.InstrumentName�  5y   "   $
 epic��65    6C   �� $
 
Model.Epic�  5z   "   $ market status��65    6L   �� $
 Model.MarketStatus�  5{   "   $ created date��65    6K   �� $
 CreatedDate�  5|   "   $  streaming prices available��65    6Y   �� $$
 Model.StreamingPricesAvailable�  5}   "   $
 high��65    6C   �� $
 
Model.High�  5~   "   $	 low��65    6B   �� $
 	Model.Low�  5   "   $
 size��65    6C   �� $
 DealSize�  5�   "   $ 	direction��65    6H   �� $
 	Direction�  5�   "   $ 
open level��65    6I   �� $
 	OpenLevel�  5�   "   $	 bid��65    6B   �� $
 	Model.Bid�  5�   "   $ offer��65    6D   �� $
 Model.Offer�  5�   "   $ change��65    6E   �� $
 Model.NetChange�  5�   "   $ 	pctChange��65    6H   �� $
 Model.PctChange�5�      �� 5�      
�������
���   �
���2͚�$��2q�6g   $��2��6{   $��20q�6�   $ Visible=�6�   $	��Top=�6   6�   �� # [ ��6�   �� *PositionDebugData+6  5�      5�      �� 5�      -   5        $ 	OrdersTab��5�   2   $��Working Orders��6    6E   �� # [ 	 6y   �� $
 OrdersTabSelected�.��5�      �  5�      �� 5�      $	��300 �6,   �� 5�      $	��300 �6,   .+�5�        $��20q�6#   $��0��6/   $	��Top=�6<    .  ��6T   �� $
 Orders� 6�   �� # [  5�        5�   "   $
 name��65    6C   �� $
 Model.InstrumentName�  5�   "   $
 epic��65    6C   �� $
 
Model.Epic�  5�   "   $ status��65    6E   �� *Model.MarketStatus+  5�   "   $ offer��65    6D   �� $
 Model.Offer�  5�   "   $	 bid��65    6B   �� $
 	Model.Bid�  5�   "   $
 size��65    6C   �� $
 	OrderSize�  5�   "   $ 	direction��65    6H   �� $
 	Direction�  5�   "   $ creation date��65    6L   �� $
 CreationDate�  5�   "   $ change��65    6E   �� $
 Model.NetChange�  5�   "   $ % change��65    6G   �� $
 Model.PctChange�  5�   "   $ streaming prices?��65    6P   �� $$
 Model.StreamingPricesAvailable�  5�   "   $ dealId��65    6E   �� $
 DealId�  5�   "   $ Streaming Id.��65    6L   �� *Model.LsItemName+  5�   "   $ Market Status��65    6L   �� *Model.MarketStatus+5�      �� 5�      
�������
���   �
���2͚�$��2q�6g   $��1��6{   $��	20,0,20,0q�6�   $ Visible=�6�   $	��Top=�6  $	��300��6)   6�   �� # [ ��6�   �� *	OrderData+6)  5�      5�      �� 5�      -   5        $ WatchlistsTab��5�   .   $��
Watchlists��6    6E   �� # [ 	 6y   �� $
 WatchlistTabSelected�.��5�      �  � ColumnDefinitions 5�      �� 5�      $��* �6/   �� 5�      $��2* �6/    5�      �� 5�      $	��300 �6,   �� 5�      $	��300 �6,   .+�5�      ]� $��0��6$   $��20q�61   $��0��6q    6=   �� # [ .+�5�        -   5          Name$ WatchlistsGrid��5�   '   $	��Top=�6?    .  ��6W   �� $
 
Watchlists� �� SelectedIndex 6   �� $
 WatchlistIndex� �� Mode$ OneWayToSource=� 5�   "     5�   &   $ Watchlist Name��69    6Q   �� *WatchlistName+6u     5�   &   $ ID��69    6E   �� *WatchlistId+6g     5�   &   $ editable��69    6K   �� *
Editable+6j     5�   &   $ 	deletable��69    6L   �� *	Deletable+6l   5�      5�      ]� 5�      $��0��6$   $��1��62   $��20q�6B    6N   �� # [ .+�5�        -   5        $ WatchlistsInstruments��5�   '   $	��Top=�6F    .  ��6^   �� $
 WatchlistMarkets� 6�   �� $
 WatchlistMarketIndex�$ OneWayToSource=� 5�   "     5�   &   $ Instrument Name��69    6R   �� *Model.InstrumentName+6}     5�   &   $ 
UpdateTime��69    6M   �� *
UpdateTime+6n     5�   &   $
 High��69    6G   �� *
Model.High+6h     5�   &   $	 Low��69    6F   �� *	Model.Low+6f     5�   &   $ Offer��69    6H   �� *Model.Offer+6j     5�   &   $	 Bid��69    6F   �� *	Model.Bid+6f     5�   &   $ Change��69    6I   �� *Model.NetChange+6o     5�   &   $ 	PctChange��69    6L   �� *Model.PctChange+6r     5�   &   $  Streaming Prices Available��69    6]   �� * Model.StreamingPricesAvailable+6�     5�   &   $ MarketStatus��69    6O   �� *Model.MarketStatus+6x   5�      5�      �� 5�      
�������
���   �$	��Top=�6M   
���2͚�$��2q�6�   $��1��6�   $��	20,0,20,0q�6�   $	��200��6�   $ Visible=�6�   $��2��6<   6�   �� # [ ��6  �� *WatchlistsData+6<  5�      5�      �� 5�      -	   5        $ 	BrowseTab��5�   *   $��Browse��6    6=   �� # [ 	 6q   �� $
 BrowseTabSelected�.��5�      �  5�      �� 5�      $��* �6/   �� 5�      $��3* �6/    5�      �� 5�      $	��300 �6,   �� 5�      $��40 �6,   �� 5�      $	��200 �6,   .+�5�        $	��Top=�6X    .  $��10,10,10,10q�6�   "   VerticalScrollBarVisibility$ Visible=�6    6$   �� # [ ��6p   �� $
 BrowseNodes� 6�   �� $
 	NodeIndex�$ TwoWay=� 5�        5�   "   $
 name��65    6C   �� $

 name�  5�   "   $ id��65    6A   �� $
 id�5�        5�      $��0��6#   $��1��60   $	��Top=�6t    .  $��10,10,10,10q�6�   $ Visible=�6�    6@   �� # [ ��6�   �� $
 BrowseMarkets� 5�        5�   "   $
 name��65    6C   �� $
 
Model.Epic�  5�   "   $ id��65    6A   �� $
 Model.InstrumentName�  5�   "   $	 bid��65    6B   �� $
 	Model.Bid�  5�   "   $ offer��65    6D   �� $
 Model.Offer�  5�   "   $
 high��65    6C   �� $
 
Model.High�  5�   "   $	 low��65    6B   �� $
 	Model.Low�  5�   "   $ Change��65    6E   �� $
 Model.NetChange�  5�   "   $ % Change��65    6G   �� $
 Model.PctChange�  5�   "   $ Streaming allowed��65    6P   �� $$
 Model.StreamingPricesAvailable�  5�   "   $ Market Status��65    6L   �� $
 Model.MarketStatus�5�      �� 5�      $��1��6!   $��5q�6.   $��0��69   $	��120��6I   $
��Root��6~   {�. ��6U   �� *GetBrowseRootCommand+ 6�   �� # [ �� 5�      $��1��6!   $��5q�6.   $��1��69   $	��120��6I   $��SubNode/Markets��6�   {�. ��6U   �� *GetBrowseMarketsCommand+ 6�   �� # [ �� 5�      
�������
���   �
���2͚�$��2q�6g   $��2��6{   $��	20,0,20,0q�6�   $	��200��6�   $ Visible=�6�   $	��Top=�6  $��2��67   6�   �� # [ ��6  �� *
BrowseData+67  5      5     5     5     5     5     