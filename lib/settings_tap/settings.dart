import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_project/my_theme.dart';
import 'package:to_do_project/settings_tap/settings_bottom_sheet.dart';
import 'package:to_do_project/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppConfigProvider provider=Provider.of<AppConfigProvider>(context,listen:false);
    provider.getPreflang();
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: (context) => SettingsLangSheet());
            },
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Themes.blue),
                  color: Themes.white,
                ),
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        provider.lang == 'en'
                            ? AppLocalizations.of(context)!.english
                            : AppLocalizations.of(context)!.arabic,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Themes.blue)),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Themes.blue,
                    )
                  ],
                )),
          ),
          SizedBox(
            height: 15,
          ),
          Text(AppLocalizations.of(context)!.mode,
              style: Theme.of(context).textTheme.titleLarge),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: (context) => SettingsModeSheet());
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Themes.white,
                    border: Border.all(color: Themes.blue)),
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        provider.isLight()
                            ? AppLocalizations.of(context)!.light
                            : AppLocalizations.of(context)!.dark,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Themes.blue)),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Themes.blue,
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
