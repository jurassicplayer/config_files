#!/usr/bin/perl

# obmenu-generator - schema file

=for comment

    item:      add an item inside the menu               {item => ["command", "label", "icon"]},
    cat:       add a category inside the menu             {cat => ["name", "label", "icon"]},
    sep:       horizontal line separator                  {sep => undef}, {sep => "label"},
    pipe:      a pipe menu entry                         {pipe => ["command", "label", "icon"]},
    raw:       any valid Openbox XML string               {raw => q(xml string)},
    begin_cat: begin of a category                  {begin_cat => ["name", "icon"]},
    end_cat:   end of a category                      {end_cat => undef},
    obgenmenu: generic menu settings                {obgenmenu => ["label", "icon"]},
    exit:      default "Exit" action                     {exit => ["label", "icon"]},

=cut

# NOTE:
#    * Keys and values are case sensitive. Keep all keys lowercase.
#    * ICON can be a either a direct path to an icon or a valid icon name
#    * Category names are case insensitive. (X-XFCE and x_xfce are equivalent)

require "$ENV{HOME}/.config/obmenu-generator/config.pl";

## Text editor
my $editor = $CONFIG->{editor};

our $SCHEMA = [
    {sep => 'Menu'},
    #          COMMAND                 LABEL                ICON
    {item => ['exo-open .',           'File',          'file-manager']},
    {item => ['urxvt',                'Term',          'terminal']},
    {item => ['exo-open http://',     'Web',           'web-browser']},
    {item => ['rofi -show',           'Run',           'system-run']},
    {sep => undef},

    #          NAME            LABEL                ICON
    {cat => ['utility',       'Apps',      'applications-utilities']},
    {cat => ['development',    'Dev',      'applications-development']},
    #{cat => ['education',   'Education',   'applications-science']},
    {cat => ['game',          'Game',      'applications-games']},
    {cat => ['graphics',      'Img',       'applications-graphics']},
    {cat => ['audiovideo',    'Media',     'applications-multimedia']},
    {cat => ['network',       'Net',       'applications-internet']},
    {cat => ['office',      'Office',      'applications-office']},
    {cat => ['other',       'Other',       'applications-other']},

    #{cat => ['qt',          'QT Applications',    'qtlogo']},
    #{cat => ['gtk',         'GTK Applications',   'gnome-applications']},
    #{cat => ['x_xfce',      'XFCE Applications',  'applications-other']},
    #{cat => ['gnome',       'GNOME Applications', 'gnome-applications']},
    #{cat => ['consoleonly', 'CLI Applications',   'applications-utilities']},

    #                  LABEL          ICON
    #{begin_cat => ['My category',  'cat-icon']},
    #             ... some items ...
    #{end_cat   => undef},

    #            COMMAND     LABEL        ICON
    #{pipe => ['obbrowser', 'Disk', 'drive-harddisk']},

    ## Generic advanced settings
    #{sep       => undef},
    #{obgenmenu => ['Openbox Settings', 'applications-engineering']},
    #{sep       => undef},

    ## Custom advanced settings
    {sep => undef},
    {cat => ['settings',    'Pref',    'applications-accessories']},
    {cat => ['system',      'Sys',      'applications-system']},
    {begin_cat => ['Adv', 'gnome-settings']},

        # Configuration files
        {item      => ["$editor ~/.config/autostartrc",   'Autostart',   $editor]},
        {item      => ["$editor ~/.conkyrc",              'Conky RC',    $editor]},

        # obmenu-generator category
        {begin_cat => ['Obmenu-Generator', 'menu-editor']},
            {item      => ["$editor ~/.config/obmenu-generator/schema.pl", 'Menu Schema', $editor]},
            {item      => ["$editor ~/.config/obmenu-generator/config.pl", 'Menu Config', $editor]},

            {sep  => undef},
            {item => ['obmenu-generator -p',    'Generate a pipe menu',              'menu-editor']},
            {item => ['obmenu-generator -s',    'Generate a static menu',            'menu-editor']},
            {item => ['obmenu-generator -p -i', 'Generate a pipe menu with icons',   'menu-editor']},
            {item => ['obmenu-generator -s -i', 'Generate a static menu with icons', 'menu-editor']},
            {sep  => undef},

            {item    => ['obmenu-generator -d', 'Refresh Icon Set', 'gtk-refresh']},
        {end_cat => undef},

        # Openbox category
        {begin_cat => ['Openbox', 'openbox']},
            {item      => ['openbox --reconfigure',               'Reconfigure Openbox', 'openbox']},
            {item      => ["$editor ~/.config/openbox/rc.xml",    'Openbox RC',           $editor]},
            {item      => ["$editor ~/.config/openbox/menu.xml",  'Openbox Menu',         $editor]},
        {end_cat => undef},
    {end_cat => undef},
    {sep => undef},

    # This options uses the default Openbox's action "Exit"
    {exit => ['Exit', 'exit']},
]
