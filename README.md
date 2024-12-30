# gtm-sw-custom-event

SalesWings Custom Event tag template for [Google Tag Manager](https://tagmanager.google.com/) is a tag template that allows sending custom events to SalesWings.

### Development and Testing

Reference documentation: [Custom templates quick start guide](https://developers.google.com/tag-platform/tag-manager/templates).

Development is done in [Google Tag Manager](https://tagmanager.google.com/).

* Log in into any account in [Google Tag Manager](https://tagmanager.google.com/)
* Select a workspace, navigate to `Templates`
* Under `Tag Templates`, click `New` to open the Template Editor
* Click the top-right button to open the editor menu, select `Import`
* Point to `template.tpl` file in this repository to import it for editing.
* Edit various sections in the editor, such as `Fields` or `Code`
* When changes are made, click `Save`, this will create / update the template in the workspace.
* Create a tag in the GTM container with the created / updated template and test the behavior of the tag end-to-end on the website where the GTM container is deployed.
* Once the testing is done, open the Template Editor again, click the top-right button to open the editor menu, select `Export` to download the edited `.tpl` file
* Replace `template.tpl` file in this repository with the downloaded `.tpl` file, commit the changes

### Release

Reference documentation: [Submit a template to the Community Template Gallery](https://developers.google.com/tag-platform/tag-manager/templates/gallery).

This template is published to the [Community Template Gallery](https://tagmanager.google.com/gallery/#/).

The publishing is done by updating `metadata.yaml` file in the `main` branch of the repository. GTM tracks changes in the file and publishes the version added
on top of the `versions` array in `metadata.yaml`. 
The `sha` field of an element in `versions` array identifies the git commit sha of the version to be published.

Release process is automated with a shell script. Once the implementation changes are merged to the `main` branch, run:
```
sh release.sh "Your release summary"
```

This script will create a branch from the latest main, update `metadata.yaml`, commit the change, push the branch to GitHub and open a GitHub pull request form 
in the browser. As any other commit to `main`, updating `metadata.yaml` should be peer reviewed to approve the release.

**(!)** It's not necessary to run the release script after every change to `main`, do it only when it's needed to update the template in the gallery.

#### Release Troubleshooting

Once `metadata.yaml` is updated in `main`, it takes GTM several days to update the template in the gallery. You can verify that the changes published by
looking at the `What's new` section of the [template page in the gallery](https://tagmanager.google.com/gallery/#/owners/SalesWings/templates/gtm-sw-custom-event), it should match the description of the latest change in `metadata.yaml`.

If the change is not published, inspect the gallery API output for errors (no authentication required):
```
curl https://tagmanager.google.com/api/gallery/owners/SalesWings/templates/gtm-sw-custom-event
```
