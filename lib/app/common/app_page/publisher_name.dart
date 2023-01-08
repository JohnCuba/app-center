/*
 * Copyright (C) 2022 Canonical Ltd
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

import 'package:flutter/material.dart';
import 'package:software/app/common/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaru_colors/yaru_colors.dart';

class PublisherName extends StatelessWidget {
  const PublisherName({
    Key? key,
    this.verified = false,
    required this.publisherName,
    this.starDev = false,
    required this.website,
    this.expandChild = true,
    this.height = 14,
    this.enhanceChildText = false,
  }) : super(key: key);

  final bool verified;
  final bool starDev;
  final String publisherName;
  final String website;
  final bool expandChild;
  final double height;
  final bool enhanceChildText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final light = theme.brightness == Brightness.light;
    var child = Text(
      publisherName,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: height,
            fontStyle: enhanceChildText ? FontStyle.italic : FontStyle.normal,
            color: enhanceChildText
                ? theme.colorScheme.onSurface.withOpacity(0.7)
                : null,
          ),
      overflow: TextOverflow.ellipsis,
    );
    return InkWell(
      onTap: () => launchUrl(Uri.parse(website)),
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (expandChild) Expanded(child: child) else child,
              if (verified)
                Padding(
                  padding: EdgeInsets.only(left: height * 0.2),
                  child: Icon(
                    Icons.verified,
                    color: light ? kGreenLight : kGreenDark,
                    size: height * 0.85,
                  ),
                )
              else if (starDev)
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: _StarDeveloper(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StarDeveloper extends StatelessWidget {
  const _StarDeveloper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: YaruColors.orange.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: Icon(
          Icons.star,
          color: Colors.white,
        ),
      ),
    );
  }
}