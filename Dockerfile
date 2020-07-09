FROM fredblgr/ubuntu-novnc:20.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y gcc ocaml menhir \
  libnum-ocaml-dev libzarith-ocaml-dev libzip-ocaml-dev \
  libmenhir-ocaml-dev liblablgtk3-ocaml-dev liblablgtksourceview3-ocaml-dev \
  libocamlgraph-ocaml-dev libre-ocaml-dev libjs-of-ocaml-dev
RUN apt-get install -y coqide alt-ergo cvc4 gedit wget

# Install Z3 4.8.6
RUN wget https://github.com/Z3Prover/z3/archive/z3-4.8.6.tar.gz \
  && tar zxf z3-4.8.6.tar.gz \
  && cd z3-z3-4.8.6; ./configure; cd build; make; make install
RUN rm -r z3-*

# Install E prover
RUN wget http://wwwlehre.dhbw-stuttgart.de/~sschulz/WORK/E_DOWNLOAD/V_2.4/E.tgz \
  && tar zxf E.tgz \
  && cd E; ./configure --prefix=/usr/local; make; make install
RUN rm -r E E.tgz

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
  && ln -s /usr/local/bin/isabelle2020 /usr/local/bin/isabelle
RUN rm Isabelle2020_linux.tar.gz
COPY resources/Isabelle2020.desktop /usr/share/applications/

# Make the JDK coming with Isabelle usable by everyone
RUN echo 'export PATH=${PATH}:/usr/local/Isabelle2020/contrib/jdk-11.0.5+10/x86_64-linux/bin' >> /root/.bashrc

# Install Why3
RUN wget https://gforge.inria.fr/frs/download.php/file/38291/why3-1.3.1.tar.gz \
  && tar zxf why3-1.3.1.tar.gz \
  && cd why3-1.3.1; ./configure; make ; \
     make install \
  && why3 config --detect-provers
RUN rm -r why3-*

# Install Eclipse Modeling 2020-06
# Copy existing configuration containing:
# * Eclipse Modeling 2020-06
# * Acceleo 3.7 from the OBEO Market Place
# * From Install New Software (with all available sites)
#   * All Acceleo
#   * Additional Interpreters for Acceleo
#   * Modeling > all QVT operational
#   * Modeling > Xpand SDK
#   * Modeling > Xtext SDK
#   * Programming languages > C/C++ Dev Tools
#   * Programming languages > C/C++ library API doc hover help
#   * Programming languages > C/C++ Unit Testing
#   * Programming languages > Eclipse XML editors and tools
#   * Programming languages > Javascript dev tools
#   * Programming languages > Wild Web developer

COPY resources/eclipse-modeling-2020-06.tgz /usr/local/
RUN cd /usr/local; tar zxf eclipse-modeling-2020-06.tgz && rm eclipse-modeling-2020-06.tgz
# Link the Java jdk from Isabelle 2020 for running Eclipse too
RUN ln -s /usr/local/eclipse-modeling-2020-06/eclipse /usr/local/bin/eclipse; \
    ln -s /usr/local/Isabelle2020/contrib/jdk-11.0.5+10/x86_64-linux/jre /usr/local/eclipse-modeling-2020-06/
COPY resources/Eclipse.desktop /usr/share/applications/

# Configuration of the file manager and the application launcher
COPY resources/dot_config/lxpanel/LXDE/panels/panel /root/.config/lxpanel/LXDE/panels/
COPY resources/dot_config/pcmanfm/LXDE/pcmanfm.conf /root/.config/pcmanfm/LXDE/

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
