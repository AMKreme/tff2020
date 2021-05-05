If you only want to get the documentation, note that a pre-built
version for the latest release is available
[online](http://skmad-suite.pages.lis-lab.fr/tff2020/).

Sphinx is used to generate the API and reference documentation.

## Instructions to build the documentation

In addition to installing ``tffpy`` and its dependencies, install the
Python packages needed to build the documentation by entering

```
pip install -r ../requirements/doc.txt
```
in the ``doc/`` directory.

To build the HTML documentation, run:
```
make html
```
in the ``doc/`` directory. This will generate a ``build/html`` subdirectory
containing the built documentation.

To build the PDF documentation, run:
```
make latexpdf
```
You will need to have Latex installed for this.
