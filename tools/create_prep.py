from pathlib import Path
import sys
import os


def main():
    for addon in os.listdir('addons'):
        addon_path = os.path.join(
            os.getcwd(), 'addons', addon)

        if (not os.path.isdir(addon_path)):
            continue

        functions = [Path(function).stem for function in Path(
            addon_path).glob('**/fnc_*.sqf')]

        if (not functions):
            continue

        print(f'Addon - {addon}: discovered functions {", ".join(functions)}')

        functions = [
            f'PREP({function[function.index("_")+1:]});' for function in functions]

        prep_path = os.path.join(addon_path, 'XEH_PREP.hpp')
        with open(prep_path, mode='wt', encoding='utf-8') as prep_file:
            prep_file.writelines(f'{function}\n' for function in functions)

    print('Finished')


if __name__ == '__main__':
    sys.exit(main())
