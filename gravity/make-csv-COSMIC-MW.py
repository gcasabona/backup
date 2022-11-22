''' `make-csv-COSMIC-MW`

########################################################
# TITLE    : make-csv-COSMIC-32-MW.py                  #    
# AUTHOR   : Julie Malewicz <julie.malewicz@gmail.com> #
# SOFTWARE : COSMIC v. 3.3.0                           #
# FUNCTION : convert COSMIC MW astrophysical           #    
#            populations from .hdf to .csv             #
# last updated on 7/17/2020                            #
########################################################

# What does this do ?
#####################

This script allows you to convert full Milky Way COSMIC files from .hdf format to .csv.
The .hdf format is primarily used for the transfer of large datasets as it allows you to save on space, 
but cannot be read as is by the user.

MW COSMIC files are sampled from COSMIC fixed populations in order to go from a statistical representative
to an actual astrophysical realization of a given population.

The script is accompanied by comments so as to make it easier for the user to modify it to fit their purpose.

You can run the script by entering
python make-csv-COSMIC-MW.py

If you are a python user, you can also simply open the files in your python script with the following:
import pandas as pd
myfile = pd.read_hdf(filename, key='galaxy')

Below, some info about the files themselves:

# file columns
################

bin_num		   Unique binary index	
tphys          Evolution time		            [Myr]
mass_1		   Primary mass		                [Msun]
mass_2		   Secondary mass		            [Msun]
kstar_1		   Type of primary star	            see kstar section
kstar_2		   Type of secondary star	        see kstar section
sep_final	   Separation	                    [Rsun] 
ecc_final	   Eccentricity	                    [ ]
porb_final	   Orbital period	                [days]
f_gw_peak	   Peak GW frequency	            [Hz]
dist		   Distance to the Sun	            [kpc]
xGx, yGx, zGx  Galacto-centric coord.           [kpc]

# kstar:
10: Helium White Dwarf          [He]
11: Carbon Oxygen White Dwarf   [CO]
12: Oxygen Neon White Dwarf     [ONe]
13: Neutron Star                [NS]
14: Black Hole                  [BH]

# Initial Parameters 
#####################

[Metallicity]
Z = 0.02  for Thin Disk and Bulge
Z = 0.003 for Thick Disk

[Physical coordinates]
xGx, yGx and zGx are assigned following the McMillan+2002 model
'''
import pandas as pd

###############
# USER INPUT #
##############

# We offer the user the possibility to only convert NS+BH or DWD populations
pop = input("Do you want to convert the full galaxy (all), only heavy compact objects (NS+BH) or maybe double white dwarfs (DWD)?\n --> ")

# Display an error message if the input isn't recognized
while pop not in ['NS+BH', 'all', 'DWD']:
    pop = input("Sorry, your input has to be either NS+BH, all or DWD \n --> ")
    
# Depending on the user's choice, the list of kstars to convert can be one of 3: 
if pop == 'DWD':
    kstar_list = ['He_He','CO_He','CO_CO', 'ONe_He_ONe']
elif pop == 'NS+BH':
    kstar_list = ['NS_NS','BH_NS','BH_BH']
elif pop == 'all':
    kstar_list = ['He_He','CO_He','CO_CO',
                  'ONe_He_ONe','NS_He_ONe','BH_He_ONe',
                  'NS_NS','BH_NS','BH_BH']

print(" ")
print("Now, would you rather have: \n",
      "    - 1 large file with the full galaxy (full) \n",
      "    - 1 file per galactic component, 3 in total (comp) \n",
      "    - 1 file per binary kstar type, up to 9 in total (kstar), \n",
      "    - 9 files per galactic component, 1 per binary kstar type, so up to 27 total (sep)?")
fileformat = input("Enter any other input for a more detailed explanation of those options \n --> ")

while fileformat not in ['full', 'kstar', 'comp', 'sep']:
    print(" full:  1 file only \n",
          "       gx_dat_full.csv \n",
          "comp:  3 files for a full gx\n",
          "       gx_dat_Bulge.csv \n",
          "       gx_dat_ThinDisk.csv \n",
          "       gx_dat_ThickDisk.csv \n",
          "kstar: 9 files for a full gx (4 for DWD and 3 for NS+BH) \n",
          "       gx_dat_He_He.csv \n",
          "       [...]\n",
          "       gx_dat_BH_BH.csv \n",
          "sep:   27 files for a full gx (12 for DWD and 9 for NS+BH) \n",
          "       gx_dat_He_He_ThinDisk.csv \n",
          "       gx_dat_He_He_ThickDisk.csv \n",
          "       gx_dat_He_He_Bulge.csv \n",
          "       [...]\n",
          "       gx_dat_BH_BH_ThinDisk.csv \n",
          "       gx_dat_BH_BH_ThickDisk.csv \n",
          "       gx_dat_BH_BH_Bulge.csv \n")
          
    fileformat = input("Now, which option sounds the best to you? full, kstar, comp or sep? \n --> ")

print(" ")
print(" This will now convert the chosen .h5 galaxy files into .csv",
      " and count up the number of binary systems in each file. \n",
      "Please be aware this might take up some time (> 2hrs).")


##############
# REAL STUFF #
##############

# Now the real stuff begins:
# We make 4 different loops, for each file format chosen by the user
# to make reading the code a bit easier maybe

reject_col = ['RROL_1', 'RROL_2', 'evol_type', 'Vsys_1',  
              'Vsys_2', 'SNkick', 'SNtheta', 'aj_1', 'aj_2',
              'tms_1', 'tms_2', 'massc_1', 'massc_2',
              'rad_1', 'rad_2', 't_birth', 't_evol_GW',
              'sep', 'porb', 'ecc']

if fileformat == 'sep':
    for kstar in kstar_list:
        print('Now converting ', kstar)
        for model in ['ThinDisk', 'ThickDisk', 'Bulge']:
            # list of columns to delete to save space
            col_to_del = reject_col.copy()
            # we load the file:
            gx = pd.read_hdf('gx_dat_'+kstar+'_'+model+'.h5', key='galaxy')
        
            # we drop a column present only for WDs, radius/RL radius which can be computed later by user if needed
            # following Eggleton+1983 e.g.
            if kstar in ['He_He','CO_He','CO_CO','ONe_He_ONe']:
                col_to_del.extend(['RL_1_final', 'RL_2_final'])
            elif kstar in ['NS_He_ONe','BH_He_ONe']:
                col_to_del.append('RL_2_final')   
            gx = gx.drop(columns=col_to_del)
            gx.to_csv('gx_dat_'+kstar+'_'+model+'.csv', index=False)
        
            # some accounting: we add a `#` to the header, making it readable as such by C codes
            gx.rename(columns = {'bin_num':'#bin_num'}, inplace = True)
            gx.to_csv('gx_dat_'+kstar+'_'+model+'.csv', index=False)
            print('  {:.2E} {} in the {}'.format(len(gx), kstar, model))

elif fileformat == 'comp':
    for model in ['ThinDisk', 'ThickDisk', 'Bulge']:
        print('Now converting ', model)
        comp_gx = pd.DataFrame()
        for kstar in kstar_list:
            col_to_del = reject_col.copy()
            gx = pd.read_hdf('gx_dat_'+kstar+'_'+model+'.h5', key='galaxy')
            if kstar in ['He_He','CO_He','CO_CO','ONe_He_ONe']:
                col_to_del.extend(['RL_1_final', 'RL_2_final'])
            elif kstar in ['NS_He_ONe','BH_He_ONe']:
                col_to_del.append('RL_2_final')   
            gx = gx.drop(columns=col_to_del)
            print('  {:.2E} {} in the {}'.format(len(gx), kstar, model))
            comp_gx = comp_gx.append(gx)
        comp_gx.rename(columns = {'bin_num':'#bin_num'}, inplace = True)
        comp_gx.to_csv('gx_dat'+model+'.csv', index=False)
            
elif fileformat == 'kstar':
    for kstar in kstar_list:
        print('Now converting ', kstar)
        kstar_gx = pd.DataFrame()
        for model in ['ThinDisk', 'ThickDisk', 'Bulge']:
            col_to_del = reject_col.copy()
            gx = pd.read_hdf('gx_dat_'+kstar+'_'+model+'.h5', key='galaxy')
            if kstar in ['He_He','CO_He','CO_CO','ONe_He_ONe']:
                col_to_del.extend(['RL_1_final', 'RL_2_final'])
            elif kstar in ['NS_He_ONe','BH_He_ONe']:
                col_to_del.append('RL_2_final')   
            gx = gx.drop(columns=col_to_del)
            print('  {:.2E} {} in the {}'.format(len(gx), kstar, model))
            kstar_gx = kstar_gx.append(gx)
        kstar_gx.rename(columns = {'bin_num':'#bin_num'}, inplace = True)
        kstar_gx.to_csv('gx_dat_'+kstar+'.csv', index=False)
        
        
elif fileformat == 'full':
    full_gx = pd.DataFrame()
    for kstar in kstar_list:
        print('Now converting', kstar)
        for model in ['ThinDisk', 'ThickDisk', 'Bulge']:
            col_to_del = reject_col.copy()      
            gx = pd.read_hdf('gx_dat_'+kstar+'_'+model+'.h5', key='galaxy')
            if kstar in ['He_He','CO_He','CO_CO','ONe_He_ONe']:
                col_to_del.extend(['RL_1_final', 'RL_2_final'])
            elif kstar in ['NS_He_ONe','BH_He_ONe']:
                col_to_del.append('RL_2_final')   
            gx = gx.drop(columns=col_to_del)
            print('  {:.2E} {} in the {}'.format(len(gx), kstar, model))
            full_gx = full_gx.append(gx)
    full_gx.rename(columns = {'bin_num':'#bin_num'}, inplace = True)
    full_gx.to_csv('gx_dat_full.csv', index=False)

print("You're ready to go!")