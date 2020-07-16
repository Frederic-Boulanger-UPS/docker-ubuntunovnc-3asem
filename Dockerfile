FROM fredblgr/ubuntu-novnc:20.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y gcc ocaml menhir \
  libnum-ocaml-dev libzarith-ocaml-dev libzip-ocaml-dev \
  libmenhir-ocaml-dev liblablgtk3-ocaml-dev liblablgtksourceview3-ocaml-dev \
  libocamlgraph-ocaml-dev libre-ocaml-dev libjs-of-ocaml-dev
# RUN apt-get install -y coqide alt-ergo cvc4 gedit wget
RUN apt-get install -y coqide alt-ergo gedit wget

# Use the SMT solvers bundled with Isabelle
# Install Z3 4.8.6
# RUN wget https://github.com/Z3Prover/z3/archive/z3-4.8.6.tar.gz \
#   && tar zxf z3-4.8.6.tar.gz \
#   && cd z3-z3-4.8.6; ./configure; cd build; make; make install
# RUN rm -r z3-*

# Install E prover
# RUN wget http://wwwlehre.dhbw-stuttgart.de/~sschulz/WORK/E_DOWNLOAD/V_2.4/E.tgz \
#   && tar zxf E.tgz \
#   && cd E; ./configure --prefix=/usr/local; make; make install
# RUN rm -r E E.tgz

# # Install Isabelle 2019
# RUN wget https://isabelle.in.tum.de/website-Isabelle2019/dist/Isabelle2019_linux.tar.gz \
#   && tar -xzf Isabelle2019_linux.tar.gz \
#   && mv Isabelle2019 /usr/local/ \
#   && ln -s /usr/local/Isabelle2019/bin/isabelle /usr/local/bin/isabelle2019 \
#   && ln -s /usr/local/bin/isabelle2019 /usr/local/bin/isabelle
# RUN rm Isabelle2019_linux.tar.gz

# Install Isabelle 2020
RUN wget https://isabelle.in.tum.de/dist/Isabelle2020_linux.tar.gz \
  && tar -xzf Isabelle2020_linux.tar.gz \
  && mv Isabelle2020 /usr/local/ \
  && ln -s /usr/local/Isabelle2020/bin/isabelle /usr/local/bin/isabelle2020 \
  && ln -s /usr/local/bin/isabelle2020 /usr/local/bin/isabelle \
  && ln -s /usr/local/Isabelle2020/contrib/cvc4-1.5-5/x86_64-linux/cvc4 /usr/local/bin/cvc4 \
  && ln -s /usr/local/Isabelle2020/contrib/e-2.0-3/x86_64-linux/eprover /usr/local/bin/eprover \
  && ln -s /usr/local/Isabelle2020/contrib/spass-3.8ds-1/x86_64-linux/SPASS /usr/local/bin/SPASS \
  && ln -s /usr/local/Isabelle2020/contrib/vampire-4.2.2/x86_64-linux/vampire /usr/local/bin/vampire \
  && ln -s /usr/local/Isabelle2020/contrib/z3-4.4.0pre-3/x86_64-linux/z3 /usr/local/bin/z3
  
RUN rm Isabelle2020_linux.tar.gz
COPY resources/Isabelle2020.desktop /usr/share/applications/
COPY resources/isabelle_properties /root/.isabelle/Isabelle2020/jedit/properties
RUN echo 'cp -r /root/.isabelle ${HOME}' >> /root/.novnc_setup

# Install Why3
RUN wget https://gforge.inria.fr/frs/download.php/file/38291/why3-1.3.1.tar.gz \
  && tar zxf why3-1.3.1.tar.gz \
  && cd why3-1.3.1; ./configure; make ; \
     make install \
  && why3 config --detect-provers
RUN rm -r why3-*

# Configuration of the file manager and the application launcher
COPY resources/dot_config/lxpanel/LXDE/panels/panel /root/.config/lxpanel/LXDE/panels/
COPY resources/dot_config/pcmanfm/LXDE/pcmanfm.conf /root/.config/pcmanfm/LXDE/
COPY resources/dot_why3.conf /root/.why3.conf
RUN echo 'cp /root/.why3.conf ${HOME}' >> /root/.novnc_setup

# # Install Why3 when working with Isabelle
# RUN wget https://gforge.inria.fr/frs/download.php/file/38291/why3-1.3.1.tar.gz \
#   && tar zxf why3-1.3.1.tar.gz \
#   && cd why3-1.3.1; ./configure; make ; \
#      echo "/usr/local/lib/why3/isabelle" >> /usr/local/Isabelle2019/etc/components ; \
#      make install \
#   && mv /root/.isabelle/Isabelle2020/heaps/polyml-5.8.1_x86_64_32-linux/{HOL-Word,Why3} \
#         /usr/local/Isabelle2020/heaps/polyml-5.8.1_x86_64_32-linux/ \
#   && mv /root/.isabelle/Isabelle2020/heaps/polyml-5.8.1_x86_64_32-linux/log/* \
#         /usr/local/Isabelle2020/heaps/polyml-5.8.1_x86_64_32-linux/log/ \
#   && why3 config --detect-provers
# RUN rm -r why3-*
